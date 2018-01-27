package br.unb.cic.reminders.aspect;

import java.util.Calendar;

import org.aspectj.lang.Signature;

import android.util.Log;

aspect Tracer {

	pointcut traceMethods() : (execution(*
			  *br.unb.cic.reminders.controller.Controller.*(..)) &&
			  !cflow(within(Tracer)));
	
	before(): traceMethods(){
		
		Calendar calendar = Calendar.getInstance();

        int hour = calendar.get(Calendar.HOUR);
        int minute = calendar.get(Calendar.MINUTE);
        int second = calendar.get(Calendar.SECOND);
        
        String current = hour + ":" + minute + ":" + second;
        
		Signature sig = thisJoinPointStaticPart.getSignature();
		String line = "" + thisJoinPointStaticPart.getSourceLocation().getLine();
		String sourceName = thisJoinPointStaticPart.getSourceLocation().getWithinType().getCanonicalName();
		
		Log.i("Reminder", current + " - Call from " + sourceName + " line " + line + " to "
				+ sig.getDeclaringTypeName() + "." + sig.getName());
	}
}


