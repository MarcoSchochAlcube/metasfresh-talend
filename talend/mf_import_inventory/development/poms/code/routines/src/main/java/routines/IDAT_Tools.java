package routines;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

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
public class IDAT_Tools {

	
    /**
     * GetDdMmYyyyFromString: returns a dd.MM.yyyy string.
     * 
     * 
     * {talendTypes} String
     * 
     * {Category} User Defined
     * 
     * {param} string("20190320") input: The date as yyyyMMdd.
     * 
     * {example} GetDdMmYyyyFromString("20190320) # 20.03.2019 !.
     */
	public static String GetDdMmYyyyFromString(String value) {
		String result;
		result = "";
		
		result = value.substring(6, 8)+"."+value.substring(4, 6)+"."+value.substring(0, 4);
		
		return result;
	}
	
    /**
     * GetRandomUUIDString: returns a random UUID string.
     * 
     * 
     * {talendTypes} String
     * 
     * {Category} User Defined
     * 
     * {param} string("world") input: The string need to be printed.
     * 
     * {example} GetRandomUUIDString() # UUID string !.
     */
    public static String GetRandomUUIDString() {
    	UUID uuid = UUID.randomUUID();
    	String randomUUIDString = uuid.toString();
    	return randomUUIDString;
    }
    
    /**
     * UrlEncode: returns a urlencoded string.
     * 
     * 
     * {talendTypes} String
     * 
     * {Category} User Defined
     * 
     * {param} string("hello world") input: The string need to be printed.
     * 
     * {example} UrlEncode("Hello World") # Hello%20World !.
     */
    public static String UrlEncode(String value) {
    	String result = java.net.URLEncoder.encode(value);
    	return result;
    }

    /**
     * UrlEncodeUTF8: returns a urlencoded string using UTF8.
     * 
     * 
     * {talendTypes} String
     * 
     * {Category} User Defined
     * 
     * {param} string("hello world") input: The string need to be printed.
     * 
     * {example} UrlEncodeUTF8("Hello World") # Hello%20World !.
     */
    public static String UrlEncodeUTF8(String value) {
    	// org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger("URIEncoderUTF8");
    	String result;
    	try {
            result = URLEncoder.encode(value, StandardCharsets.UTF_8.toString());
            // logger.info(result);
        } catch (UnsupportedEncodingException ex) {
            throw new RuntimeException(ex.getCause());
        }
    	return result;
    }
    
    public static String StripTimePart(String value) {
    	String result = value.split("T")[0];
    	return result;
    }
}
