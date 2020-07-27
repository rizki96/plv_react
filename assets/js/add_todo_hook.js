const AddTodoHook = {
    mounted() {
        console.log("mounted");
        $('#todo_text').val('');
    }/*,
    updated() {
        console.log("updated");
    }*/
}

export default AddTodoHook;