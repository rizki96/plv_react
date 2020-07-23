import React from "react";
import "./todo_list_item.scss";
import {Todo, ToggleComplete} from "./types";

interface TodoListItemProps {
  todo: Todo;
  toggleComplete: ToggleComplete;
}

export const TodoListItem: React.FC<TodoListItemProps> = ({
    todo,
    toggleComplete
}) => {
    return (
        <li>
            <label className={todo.completed ? "complete" : undefined}>
            <input
                type="checkbox"
                onChange={() => toggleComplete(todo)}
                checked={todo.completed}
            />
            {todo.text}
            </label>
        </li>
    );
};