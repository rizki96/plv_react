import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { AddTodoForm } from "./add_todo_form";
import { TodoList } from "./todo_list";
import { Todo, AddTodo, ToggleComplete } from "./types";

interface LiveViewProps {
    name: string;
    todos: Array<Todo>;
    pushEvent: any;
    pushEventTo: any;
    handleEvent: any;
}

const Todo: React.FC<LiveViewProps> = ({ 
    name, 
    todos, 
    pushEvent, 
    pushEventTo, 
    handleEvent 
}: LiveViewProps) => {

    React.useEffect(() => {
        console.log("init_todos")
        console.log(todos)
    }, [])

    React.useEffect(() => {
        if (!handleEvent) return;
        handleEvent("add_todo_result", (data) => {
            // use data to update your component
            console.log("add_todo_result")
            console.log(data)
        })
    }, [handleEvent])

    React.useEffect(() => {
        if (!todos) return
        console.log("todos")
        console.log(todos)
    }, [todos])

    const toggleComplete: ToggleComplete = selectedTodo => {
        const _updatedTodos = todos.map(todo => {
            if (todo === selectedTodo) {
                pushEvent("update_todo", { ...todo, completed: !todo.completed }); // sync to server
                return { ...todo, completed: !todo.completed };
            }
            return todo;
        });
    };

    const addTodo: AddTodo = newTodo => {
        newTodo.trim() !== "" 
        && pushEvent("add_todo", {"text": newTodo})
    };

    return (
        <div>this is {name}
            <React.Fragment>
                <TodoList todos={todos} toggleComplete={toggleComplete} />
                <AddTodoForm addTodo={addTodo} />
            </React.Fragment>
        </div>
    );
};

export default Todo;
