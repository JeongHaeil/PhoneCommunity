package xyz.itwill.exception;

public class ExistsUserException extends RuntimeException {
    private static final long serialVersionUID = 1L;
    private Object user;

    public ExistsUserException(String message, Object user) {
        super(message);
        this.user = user;
    }

    public Object getUser() {
        return user;
    }
}
