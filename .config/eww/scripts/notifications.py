#!/usr/bin/python
import gi
gi.require_version("GdkPixbuf", "2.0")
gi.require_version("Gtk", "3.0")
import subprocess
from gi.repository import Gtk, GdkPixbuf
import json
import sys
import typing
import os
import datetime
from gi.repository import GLib
from dbus.mainloop.glib import DBusGMainLoop
import dbus.service
import dbus


cache_dir = f"{os.getenv('HOME')}/.cache/notify_img_data"
log_file = f"{os.getenv('HOME')}/.cache/notifications.json"
os.makedirs(cache_dir, exist_ok=True)
active_popups = {}

# RECIEVE NOTIFICATIONS


class NotificationDaemon(dbus.service.Object):
    def __init__(self):
        bus_name = dbus.service.BusName(
            "org.freedesktop.Notifications", dbus.SessionBus())
        dbus.service.Object.__init__(
            self, bus_name, "/org/freedesktop/Notifications")
        self.dnd = False

    @dbus.service.method("org.freedesktop.Notifications", in_signature="susssasa{sv}i", out_signature="u")
    def Notify(self, app_name, replaces_id, app_icon, summary, body, actions, hints, timeout):
        replaces_id = int(replaces_id)
        actions = list(actions)
        app_icon = str(app_icon)
        app_name = str(app_name)
        summary = str(summary)
        body = str(body)

        current = self.read_log_file()
        new_id = 0

        if replaces_id != 0 and any(n for n in current["notifications"] if n["id"] == replaces_id):
            # Find and replace the existing notification
            for i, notification in enumerate(current["notifications"]):
                if notification["id"] == replaces_id:
                    current["notifications"].pop(i)

                    replace_notification = self.create_notification_details(
                        id=replaces_id,
                        app_name=app_name,
                        app_icon=app_icon,
                        summary=summary,
                        body=body,
                        actions=actions,
                        hints=hints
                    )

                    current["notifications"].insert(0, replace_notification)
                    break
        else:
            # Assign a new ID and create a new notification
            if replaces_id != 0:
                new_id = replaces_id
            else:
                if len(current["notifications"]) > 0:
                    new_id = current["notifications"][0]["id"] + 1

            new_notification_details = self.create_notification_details(
                id=new_id,
                app_name=app_name,
                app_icon=app_icon,
                summary=summary,
                body=body,
                actions=actions,
                hints=hints
            )
            current["notifications"].insert(0, new_notification_details)


        current["count"] = len(current["notifications"])
        self.write_log_file(current)

        if not self.dnd and not self.check_control_center_open():
            self.save_popup(current["notifications"][0], replaces_id)

        return new_id

    def create_notification_details(self, id, app_name, app_icon, summary, body, actions, hints):
        acts = []
        for i in range(0, len(actions), 2):
            acts.append([str(actions[i]), str(actions[i + 1])])

        details = {
            "id": id,
            "app": app_name,
            "summary": self.format_long_string(summary, 45),
            "body": self.format_long_string(body, 45),
            "time": datetime.datetime.now().strftime("%H:%M"),
            "urgency": hints.get("urgency", 1),  # Default urgency to 1 if not specified
            "actions": acts
        }

        acts = []
        for i in range(0, len(actions), 2):
            acts.append([str(actions[i]), str(actions[i + 1])])

        if app_icon.strip():
            if os.path.isfile(app_icon) or app_icon.startswith("file://"):
                details["image"] = app_icon
            else:
                details["image"] = self.get_gtk_icon(app_icon)
        else:
            details["image"] = None

        if "image-data" in hints:
            details["image"] = f"{cache_dir}/{details['id']}.png"
            self.save_img_byte(hints["image-data"], details["image"])

        return details

    def format_long_string(self, long_string, interval):
        split_string = []
        max_length = 256

        for i in range(0, len(long_string), interval):
            split_string.append(long_string[i:i+interval])

        result = "-\n".join(split_string)

        if len(result) > max_length:
            result = result[:max_length] + "..."

        return result

    @dbus.service.method("org.freedesktop.Notifications", in_signature="", out_signature="ssss")
    def GetServerInformation(self):
        return ("linkfrg's notification daemon", "linkfrg", "1.0", "1.2")

    @dbus.service.method("org.freedesktop.Notifications", in_signature="", out_signature="as")
    def GetCapabilities(self):
        return ("actions", "body", "icon-static", "persistence")

    @dbus.service.signal("org.freedesktop.Notifications", signature="us")
    def ActionInvoked(self, id, action):
        return (id, action)

    @dbus.service.method("org.freedesktop.Notifications", in_signature="us", out_signature="")
    def InvokeAction(self, id, action):
        self.ActionInvoked(id, action)

    @dbus.service.signal("org.freedesktop.Notifications", signature="uu")
    def NotificationClosed(self, id, reason):
        return (id, reason)

    @dbus.service.method("org.freedesktop.Notifications", in_signature="u", out_signature="")
    def CloseNotification(self, id):
        current = self.read_log_file()
        current["notifications"] = [
            n for n in current["notifications"] if n["id"] != id]
        current["count"] = len(current["notifications"])

        self.write_log_file(current)
        self.NotificationClosed(id, 2)
        self.DismissPopup(id)

    @dbus.service.method("org.freedesktop.Notifications", in_signature="", out_signature="")
    def ToggleDND(self):
        match self.dnd:
            case False:
                self.dnd = True
            case True:
                self.dnd = False

    @dbus.service.method("org.freedesktop.Notifications", in_signature="", out_signature="")
    def GetDNDState(self):
        subprocess.run(
            ["/home/rodion/bin/eww", "update", f"do-not-disturb={json.dumps(self.dnd)}"])

    def get_gtk_icon(self, icon_name):
        theme = Gtk.IconTheme.get_default()
        icon_info = theme.lookup_icon(icon_name, 128, 0)

        if icon_info is not None:
            return icon_info.get_filename()

    def save_img_byte(self, px_args: typing.Iterable, save_path: str):
        GdkPixbuf.Pixbuf.new_from_bytes(
            width=px_args[0],
            height=px_args[1],
            has_alpha=px_args[3],
            data=GLib.Bytes(px_args[6]),
            colorspace=GdkPixbuf.Colorspace.RGB,
            rowstride=px_args[2],
            bits_per_sample=px_args[4],
        ).savev(save_path, "png")

    def write_log_file(self, data):
        output_json = json.dumps(data, indent=2)
        subprocess.run(["/home/rodion/bin/eww", "update", f"notifications={output_json}"])
        with open(log_file, "w") as log:
            log.write(output_json)

    def read_log_file(self):
        empty = {"count": 0, "notifications": [], "popups": []}
        try:
            with open(log_file, "r") as log:
                return json.load(log)
        except FileNotFoundError:
            with open(log_file, "w") as log:
                json.dump(empty, log)
            return empty

    def check_control_center_open(self):
        result = subprocess.run(["/home/rodion/bin/eww", "get", "control_center_opened"], capture_output=True, text=True)
        return result.stdout.strip() == "true"    

    @dbus.service.method("org.freedesktop.Notifications", in_signature="", out_signature="")
    def ClearAll(self):
        for notify in self.read_log_file()["notifications"]:
            self.NotificationClosed(notify["id"], 2)
        data = {"count": 0, "notifications": [], "popups": []}

        self.write_log_file(data)

    # OPERATIONS WITH POPUPS

    def save_popup(self, notification, replaces_id):
        global active_popups

        current = self.read_log_file()
        popups = current["popups"]
        popup_id = notification["id"]
        replaced = False

        # Replace the existing popup with the new notification
        if replaces_id != 0 and len(popups) > 0:
            for i in range(len(popups)):
                if popups[i]["id"] == replaces_id:
                    popups[i] = notification
                    replaced = True
                    break

        if not replaced:
            if len(popups) >= 3:
                oldest_popup = popups.pop()
                self.DismissPopup(oldest_popup["id"])

            popups.append(notification)

        self.write_log_file(current)

        # Remove the old timer if exists
        if popup_id in active_popups:
            GLib.source_remove(active_popups[popup_id])  

        active_popups[popup_id] = GLib.timeout_add_seconds(
            5, self.DismissPopup, popup_id)

    @dbus.service.method("org.freedesktop.Notifications", in_signature="u", out_signature="")
    def DismissPopup(self, id):
        global active_popups

        current = self.read_log_file()
        current["popups"] = [n for n in current["popups"] if n["id"] != id]
        self.write_log_file(current)

        active_popups.pop(id, None)

    @dbus.service.method("org.freedesktop.Notifications", in_signature="", out_signature="")
    def GetCurrent(self):
        subprocess.run(
            ["/home/rodion/bin/eww", "update", f"notifications={json.dumps(self.read_log_file())}"])


# MAINLOOP

def main():
    DBusGMainLoop(set_as_default=True)
    loop = GLib.MainLoop()
    NotificationDaemon()
    try:
        loop.run()
    except KeyboardInterrupt:
        exit(0)


if __name__ == "__main__":
    main()
