import React from "react";
import { Todo, ToggleComplete } from "./types";
import { TodoListItem } from "./todo_list_item";

interface TodoListProps {
    todos: Array<Todo>;
    toggleComplete: ToggleComplete;
}

export const TodoList: React.FC<TodoListProps> = ({
    todos,
    toggleComplete
}) => {
    return (
        <ul>
            {todos.map(todo => (
            <TodoListItem
                key={todo.id}
                todo={todo}
                toggleComplete={toggleComplete}
            />
            ))}
        </ul>
    );
};