const TodoListItemHook = {
    mounted() {
        console.log("mounted");
        $('#todo_text').val('');
    }/*,
    updated() {
    }*/
}

export default TodoListItemHook;