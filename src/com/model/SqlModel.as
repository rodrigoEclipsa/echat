package com.model
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.net.ObjectEncoding;
	
	import mx.utils.ObjectUtil;
	
	import util.sql.HistoryChatVO;
	import util.vo.ChatVO;
	
	
	[Bindable]
	public class SqlModel
	{
		
		private var appDB:SQLConnection;
		private var dbStatement:SQLStatement;
		
		
		[Inject]
		public var loginModel:LoginModel;
		
		
		[PostConstruct]
		public function SqlModel_postConstruct():void
		{
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("chatWebMovile.db");
			
		//	trace("dbFile : " + dbFile)
			
			dbStatement = new SQLStatement();
			dbStatement.itemClass = HistoryChatVO
			appDB = new SQLConnection();
			dbStatement.sqlConnection =  appDB;
			appDB.addEventListener(SQLEvent.OPEN, databaseOpenHandler);
			appDB.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			appDB.open(dbFile);
			
		}
		
	
		
		private function databaseOpenHandler(event:SQLEvent):void
		{
			
			dbStatement.text = "CREATE TABLE IF NOT EXISTS history_chat ( id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, anonymous_user TEXT," +
				"body TEXT," +
				"checked_message BOOLEAN NULL," +
				"state TEXT," +
				"time NUMBER)";
			
			dbStatement.addEventListener(SQLEvent.RESULT, resultHandler);
			dbStatement.addEventListener(SQLErrorEvent.ERROR, createErrorHandler);
			dbStatement.execute();
			
			// refresh employee list on open
			//addHistoryChat("rodrigo","ds54dsa5","hola este es un mensage",true,"My",4654564456);
			
			//getHistoryChat("rodrigo","ds54dsa5");
		}
		
		
		
		private function resultHandler(event:SQLEvent):void
		{
			
			var result:SQLResult = dbStatement.getResult();
			if (result != null) {  
				trace("averr : " + ObjectUtil.toString(result.data));
			}
			
			
			
		}
		
		
		
		public function addHistoryChat(username:String,anonymous_user:String,body:String,state:String,time:Number,checked_message:Boolean =null):void
		{
			
		
			dbStatement.text = "INSERT into history_chat(username,anonymous_user,body,checked_message,state,time) " +
				"values(@username,@anonymous_user,@body,@checked_message,@state,@time)";
			
			dbStatement.parameters["@username"] = username;
			dbStatement.parameters["@anonymous_user"] = anonymous_user;
			dbStatement.parameters["@body"] = body;
			dbStatement.parameters["@checked_message"] = checked_message;
			dbStatement.parameters["@state"] = state;
			dbStatement.parameters["@time"] = time;
			
			
			
	
			dbStatement.execute();
			
			
		}
		
		
		public function getHistoryChat(username:String,anonymous_user:String):void
		{
			
			dbStatement.text = "SELECT * FROM history_chat WHERE username = @username AND anonymous_user = @anonymous_user ";
			
			dbStatement.parameters["@username"] = username;
			dbStatement.parameters["@anonymous_user"] = anonymous_user;
			
			dbStatement.execute();
			
			
		}
		
		
		private function createErrorHandler(event:SQLErrorEvent):void
		{
			
			trace("Error Occurred with id: " + event.error.errorID  + " message " + event.error.message);
		
		
		}
		
		
		private function errorHandler(error:SQLError):void
		{
			trace("Error Occurred with id: " + error.errorID  + " operation " + error.operation + " message " + error.message);
		}
		
		
	}
}