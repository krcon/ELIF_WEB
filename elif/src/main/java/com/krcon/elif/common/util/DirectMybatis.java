package com.krcon.elif.common.util;

import java.sql.Connection;

import org.apache.ibatis.session.ExecutorType;

import org.apache.ibatis.session.SqlSession;

import org.apache.ibatis.session.SqlSessionFactory;

import org.apache.ibatis.session.TransactionIsolationLevel;

import org.springframework.context.support.ClassPathXmlApplicationContext;

public class DirectMybatis {

	private SqlSessionFactory factory = null;

	private SqlSession sess = null;

	public DirectMybatis() {

		createFactory();

	}

	public DirectMybatis(String mybatisContextPath) {
		createFactory(mybatisContextPath);
	}

	
	/** 
	 * @return SqlSessionFactory
	 */
	public SqlSessionFactory createFactory() {
		return createFactory("classpath:config/mybatis-context.xml");
	}

	
	/** 
	 * @param mybatisContextPath
	 * @return SqlSessionFactory
	 */
	public SqlSessionFactory createFactory(String mybatisContextPath) {
		if (mybatisContextPath == null) {
			return factory;
		}

		try {
			try (ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(mybatisContextPath)) {
				factory = (SqlSessionFactory) context.getBean("sqlSessionFactory");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return factory;
	}

	
	/** 
	 * @return SqlSession
	 */
	public SqlSession createSession() {
		if (factory != null) {
			sess = factory.openSession();
		}

		return sess;

	}

	
	/** 
	 * @param configPath
	 * @param autoCommit
	 * @return SqlSession
	 */
	public SqlSession createSession(String configPath, boolean autoCommit) {
		if (factory != null) {
			sess = factory.openSession(autoCommit);
		}

		return sess;
	}

	
	/** 
	 * @param configPath
	 * @param connection
	 * @return SqlSession
	 */
	public SqlSession createSession(String configPath, Connection connection) {
		if (factory != null) {
			sess = factory.openSession(connection);
		}

		return sess;
	}

	
	/** 
	 * @param configPath
	 * @param execType
	 * @return SqlSession
	 */
	public SqlSession createSession(String configPath, ExecutorType execType) {
		if (factory != null) {
			sess = factory.openSession(execType);
		}

		return sess;
	}

	
	/** 
	 * @param configPath
	 * @param level
	 * @return SqlSession
	 */
	public SqlSession createSession(String configPath, TransactionIsolationLevel level) {
		if (factory != null) {
			sess = factory.openSession(level);
		}

		return sess;
	}

	
	/** 
	 * @param configPath
	 * @param execType
	 * @param autoCommit
	 * @return SqlSession
	 */
	public SqlSession createSession(String configPath, ExecutorType execType, boolean autoCommit) {
		if (factory != null) {
			sess = factory.openSession(execType, autoCommit);
		}

		return sess;
	}

	
	/** 
	 * @param configPath
	 * @param execType
	 * @param connection
	 * @return SqlSession
	 */
	public SqlSession createSession(String configPath, ExecutorType execType, Connection connection) {
		if (factory != null) {
			sess = factory.openSession(execType, connection);
		}

		return sess;
	}

	
	/** 
	 * @param configPath
	 * @param execType
	 * @param level
	 * @return SqlSession
	 */
	public SqlSession createSession(String configPath, ExecutorType execType, TransactionIsolationLevel level) {
		if (factory != null) {
			sess = factory.openSession(execType, level);
		}

		return sess;
	}

	
	/** 
	 * @return SqlSessionFactory
	 */
	public SqlSessionFactory getFactory() {
		return factory;
	}

	
	/** 
	 * @return SqlSession
	 */
	public SqlSession getSession() {
		return sess;
	}

	public void close() {
		if (sess != null) {
			sess.close();
		}

		sess = null;
		factory = null;
	}

}