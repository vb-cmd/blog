function Comment({comment}) {
    return ( 
        <div className="m-1 p-2 rounded-3 border border-info bg-light-subtle text-body-tertiary">
            <h5 className="text-center text-muted">{comment.user_name}</h5>
            <div className="text-break">{comment.content}</div>
        </div>
     );
}

export default Comment;