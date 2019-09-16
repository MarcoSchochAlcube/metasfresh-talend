package routines;


/*
 * user specification: the function's comment should contain keys as follows: 1. write about the function's comment.but
 * it must be before the "{talendTypes}" key.
 * 
 * 2. {talendTypes} 's value must be talend Type, it is required . its value should be one of: String, char | Character,
 * long | Long, int | Integer, boolean | Boolean, byte | Byte, Date, double | Double, float | Float, Object, short |
 * Short
 * 
 * 3. {Category} define a category for the Function. it is required. its value is user-defined .
 * 
 * 4. {param} 's format is: {param} <type>[(<default value or closed list values>)] <name>[ : <comment>]
 * 
 * <type> 's value should be one of: string, int, list, double, object, boolean, long, char, date. <name>'s value is the
 * Function's parameter name. the {param} is optional. so if you the Function without the parameters. the {param} don't
 * added. you can have many parameters for the Function.
 * 
 * 5. {example} gives a example for the Function. it is optional.
 */
public class LOG4J_Tools {

    /**
     * helloExample: not return value, only print "hello" + message.
     * 
     * 
     * {talendTypes} String
     * 
     * {Category} User Defined
     * 
     * {param} string("world") input: The string need to be printed.
     * 
     * {example} helloExemple("world") # hello world !.
     */
    public static void helloExample(String message) {
        if (message == null) {
            message = "World"; //$NON-NLS-1$
        }
        System.out.println("Hello " + message + " !"); //$NON-NLS-1$ //$NON-NLS-2$
    }

    /**
     * helloExample: not return value, only print "hello" + message.
	 * usage: 
	 * LOG4J_Tools.writeToLog4j("MyLogger", "info", "JobSimple", "42", "Kind am Start Id: " + input_row.Id + " Alter: " + input_row.Alter);
     * 
     * 
     * {talendTypes} String
     * 
     * {Category} User Defined
     * 
     * {param} string("world") input: The string need to be printed.
     * 
     * {example} writeToLog4j("loggerName", "info", "myComponent", 42, "message") # Write Logentry.
     */
    public static void writeToLog4j(String loggerName, String severity,  String component, String code, String message) {
    	org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(loggerName);
    	//org.apache.log4j.Level VERBOSE = org.apache.log4j.Level.forName("VERBOSE");
    	//logger.log(org.apache.log4j.Level.toPriority(50001),message);
    	String out = String.format("%s|%s|%s", component, code, message);
    	switch (severity.toLowerCase()) {
		case "debug": 
			logger.debug(out);
		break;
		case "trace": 
			logger.trace(out);
		break;
		case "info": 
			logger.info(out);
		break;
		case "warn": 
			logger.warn(out);
		break;
		case "error": 
			logger.error(out);
		break;
		case "fatal": 
			logger.fatal(out);
		break;

		default:
			logger.info(message);
			break;
		}
    }
    
}
