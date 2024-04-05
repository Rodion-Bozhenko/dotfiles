local todo_setup, todo = pcall(require, "todo-comments")
if not todo_setup then
	return
end

todo.setup({})
