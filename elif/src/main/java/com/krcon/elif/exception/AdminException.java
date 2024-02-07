package com.krcon.elif.exception;

public class AdminException extends RuntimeException {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructs an {@code AdminException} with the specified message and no
	 * root cause.
	 * @param msg the detail message
	 */
	public AdminException(String msg) {
		super(msg);
	}

	/**
	 * Constructs an {@code AdminException} with the specified message and root
	 * cause.
	 * @param msg the detail message
	 * @param cause the root cause
	 */
	public AdminException(String msg, Throwable cause) {
		super(msg, cause);
	}
}