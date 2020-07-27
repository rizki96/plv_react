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
    const [getTodos, setTodos] = React.useState<Array<Todo>>(todos);

    const mounted = React.useRef(todos);
    
    React.useEffect(() => {
        if (!mounted.current) {
            // do componentDidMount logic
            mounted.current = getTodos;
        } else {
            // do componentDidUpdate logic
            mounted.current = getTodos;
        }
    });

    React.useEffect(() => {
        console.log("init_todos")
        console.log(getTodos)
    }, [])

    React.useEffect(() => {
        if (!handleEvent) return;
        handleEvent("add_todo_result", (data: any) => {
            // use data to update your component
            console.log("add_todo_result")
            console.log(data.add_todo.id, data.add_todo.completed)
            setTodos(mounted.current.concat([data.add_todo]))
        });
        handleEvent("update_todo_result", (data: any) => {
            // use data to update your component
            console.log("update_todo_result")
            console.log(data.update_todo.id, data.update_todo.completed)
            const updatedTodos = mounted.current.map(todo => {
                if (todo.id === data.update_todo.id) {
                    return { ...todo, completed: data.update_todo.completed };
                }
                return todo;
            });
            setTodos(updatedTodos)
        });
    }, [handleEvent])

    React.useEffect(() => {
        if (!todos) return
        console.log("todos")
        console.log(todos)
    }, [todos])

    const toggleComplete: ToggleComplete = selectedTodo => {
        getTodos.map(todo => {
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
                <TodoList todos={getTodos} toggleComplete={toggleComplete} />
                <AddTodoForm addTodo={addTodo} />
            </React.Fragment>
        </div>
    );
};

export default Todo;
