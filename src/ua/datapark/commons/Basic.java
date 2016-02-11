package ua.datapark.commons;

import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

public class Basic {
	// сделать конструктор дл€ класса с опредлением констант дл€ локализации и календар€ 
	
	public static Locale defaultLocale = Locale.ENGLISH;
/*		
	Value "Europe/Kiev" given host message 
	ORA-00604: error occurred at recursive SQL level 1 
	ORA-01882: timezone region  not found
*/	
	public static String gefaultTimeZone = "EET"; // "GMT+2:00";
/*	    	
	String[] tzIDs = TimeZone.getAvailableIDs();
	for (int i = 0; i < tzIDs.length; i++) {
		String tzID = tzIDs[i];
		Log("TimeZone ID["+i+"] is value: "+tzID);				
	}
*/		
	public static void Log(String str) { 
		System.out.println((new SimpleDateFormat("E, dd-MMM-yyyy, HH:mm:ss z", defaultLocale)).format(new Date())+" "+str);
	}
	
	public static void Logerr(String str) { 
		System.err.println((new SimpleDateFormat("E, dd-MMM-yyyy, HH:mm:ss z", defaultLocale)).format(new Date())+" "+str);		
	}
	
	public static String toDate(String epoch) {
		// TimeZone tz = TimeZone.getTimeZone(gefaultTimeZone);
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone(gefaultTimeZone));
		
		long lon = (epoch == "") ? System.currentTimeMillis() : Long.parseLong(epoch); 
		cal.setTimeInMillis(lon);
		
		return  String.valueOf(cal.get(Calendar.YEAR))+"-"+
				formatNumber(2,2,0,0, cal.get(Calendar.MONTH)+1)+"-"+
				formatNumber(2,2,0,0, cal.get(Calendar.DAY_OF_MONTH))+" "+
				formatNumber(2,2,0,0, cal.get(Calendar.HOUR_OF_DAY))+":"+
				formatNumber(2,2,0,0, cal.get(Calendar.MINUTE))+":"+
				formatNumber(2,2,0,0, cal.get(Calendar.SECOND));
	}
	
	public static String toDate() {
		// TimeZone tz = TimeZone.getTimeZone(gefaultTimeZone);
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone(gefaultTimeZone));
		
		cal.setTimeInMillis(System.currentTimeMillis());
		
		return  String.valueOf(cal.get(Calendar.YEAR))+"-"+
				formatNumber(2,2,0,0,cal.get(Calendar.MONTH)+1)+"-"+
				formatNumber(2,2,0,0,cal.get(Calendar.DAY_OF_MONTH))+" "+
				formatNumber(2,2,0,0,cal.get(Calendar.HOUR_OF_DAY))+":"+
				formatNumber(2,2,0,0,cal.get(Calendar.MINUTE))+":"+
				formatNumber(2,2,0,0,cal.get(Calendar.SECOND));
	}
	
	public static String minusMonth(String dat) {
		// TimeZone tz = TimeZone.getTimeZone(gefaultTimeZone);
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone(gefaultTimeZone));
		
		cal.set(Integer.parseInt(dat.substring(0,4)),
				Integer.parseInt(dat.substring(5,7)),
				0, 0, 0, 0);
		cal.add(Calendar.MONTH,-1);
		
		return  String.valueOf(cal.get(Calendar.YEAR))+"-"+
				formatNumber(2,2,0,0,cal.get(Calendar.MONTH)+1);
	}
	
	public static String toDay(String epoch) {
		// TimeZone tz = TimeZone.getTimeZone(gefaultTimeZone);
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone(gefaultTimeZone));
		long lon;
		
		if (epoch.equals("")) {
			lon = System.currentTimeMillis();
		} else {
			lon = Long.parseLong(epoch);
		}
		
		cal.setTimeInMillis(lon);
		return  String.valueOf(cal.get(Calendar.YEAR))+"-"+
				formatNumber(2,2,0,0,cal.get(Calendar.MONTH)+1)+"-"+
				formatNumber(2,2,0,0,cal.get(Calendar.DAY_OF_MONTH));
	}
	
	public static String toEpoch(String date) {
		// TimeZone tz = TimeZone.getTimeZone(gefaultTimeZone);
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone(gefaultTimeZone));
		
		cal.set(Integer.parseInt(date.substring(0,4)),
				Integer.parseInt(date.substring(5,7))-1,
				Integer.parseInt(date.substring(8,10)),
				Integer.parseInt(date.substring(11,13)),
				Integer.parseInt(date.substring(14,16)),
				Integer.parseInt(date.substring(17,19)));
		
		return String.valueOf(cal.getTimeInMillis());
	}
	
    public static String formatNumber (int min, int max, int fmin, int fmax, double value){
        NumberFormat nf = NumberFormat.getInstance();
        
        nf.setMinimumIntegerDigits(min);
        nf.setMaximumIntegerDigits(max);
        nf.setMinimumFractionDigits(fmin);
        nf.setMaximumFractionDigits(fmax);
        nf.setGroupingUsed(true);
        
        return nf.format(value);
    }
    
    public static String fracNumber(long val) {
        NumberFormat nf = NumberFormat.getInstance();
        nf.setGroupingUsed(true);
    	return nf.format(val);
    }
    
	public static String toHHMMSS(String p){
		long period = Long.parseLong(p);
		long hour = period / 3600;
		long min = (period % 3600) / 60;
		long sec = (period % 3600) % 60;
		
		return formatNumber(2,5,0,0,hour)+":"+formatNumber(2,2,0,0,min)+":"+formatNumber(2,2,0,0,sec);
	}
	
	public static int gethour(String epoch) {
		// TimeZone tz = TimeZone.getTimeZone(gefaultTimeZone);
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone(gefaultTimeZone));
		
		cal.setTimeInMillis(Long.parseLong(epoch));
		return cal.get(Calendar.HOUR_OF_DAY);
	}

	public static int getweekday(String epoch) {
		// TimeZone tz = TimeZone.getTimeZone(gefaultTimeZone);
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone(gefaultTimeZone));
		
		cal.setTimeInMillis(Long.parseLong(epoch));
		return cal.get(Calendar.DAY_OF_WEEK);
	}
	
    public static String monthName (int m) {
		String value="вкаж≥ть м≥с€ць";
    	switch (m) {
			case 1: value = "с≥чень"; break;
			case 2: value = "лютий"; break;
			case 3: value = "березень"; break;
			case 4: value = "кв≥тень"; break;
			case 5: value = "травень"; break;
			case 6: value = "червень"; break;
			case 7: value = "липень"; break;
			case 8: value = "серпень"; break;
			case 9: value = "вересень"; break;
			case 10: value = "жовтень"; break;
			case 11: value = "листопад"; break;
			case 12: value = "грудень"; break;
		}				
		return value;
    }
    
    public static String monthNameRod (int m) {
		String value="вкаж≥ть м≥с€ць";
    	switch (m) {
			case 1: value = "с≥чн€"; break;
			case 2: value = "лютого"; break;
			case 3: value = "березн€"; break;
			case 4: value = "кв≥тн€"; break;
			case 5: value = "травн€"; break;
			case 6: value = "червн€"; break;
			case 7: value = "липн€"; break;
			case 8: value = "серпн€"; break;
			case 9: value = "вересн€"; break;
			case 10: value = "жовтн€"; break;
			case 11: value = "листопада"; break;
			case 12: value = "грудн€"; break;
		}				
		return value;
    }
    
    public static long substractDates(String dat_start, String dat_end) {
    	long value = 0;
    	// TimeZone tz = TimeZone.getTimeZone(gefaultTimeZone);
    	Calendar cal = Calendar.getInstance(TimeZone.getTimeZone(gefaultTimeZone));
		
		cal.set(Integer.parseInt(dat_end.substring(0,4)),
				Integer.parseInt(dat_end.substring(5,7)),
				Integer.parseInt(dat_end.substring(8,10)));
		long msec_start = cal.getTimeInMillis();
		
		cal.set(Integer.parseInt(dat_start.substring(0,4)),
				Integer.parseInt(dat_start.substring(5,7)),
				Integer.parseInt(dat_start.substring(8,10)));
		value = (msec_start - cal.getTimeInMillis())/1000/60/60/24;
		
    	return value;
    }    
}
