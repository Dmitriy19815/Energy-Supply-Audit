<%@ page import="java.io.*" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.awt.image.*" %>
<%@ page import="org.joshy.*" %>
<%@ page import="javax.imageio.*" %>
<%@ page import="ua.datapark.commons.Basic" %>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._Range"/>
<%
	//String colr_qua = "3F69D9";
	String colr_qua = "49BF2C";
	String colr_gen = "FF0000";
	
//	String z0 = "EEEEEE";
//	String z1 = "E1F2FF";
//	String z2 = "FFFED5";
//	String z3 = "FFEAEA";
	
	//String z0 = "EEEEEE";
	String z1 = "B2E4FF";
	String z2 = "FFFDA6";
	String z3 = "FFC2C2";
	String str = "";
	
	String ks = request.getParameter("ks");
	String obl = request.getParameter("obl");
	if (ks==null && obl==null) { %>no object<br><%  }
	String point = request.getParameter("point");
	if (point==null) { %>no point<br><%  }

	String day1 = request.getParameter("day1");
	if (day1==null) { %>?? ?????? ???? 1<br><% }
	String month1 = request.getParameter("month1");
	if (month1==null) { %>?? ?????? ????? 1<br><% }
	String year1 = request.getParameter("year1");
	if (year1==null) { %>?? ?????? ??? 1<br><% }

	String day2 = request.getParameter("day2");
	if (day2==null) { %>?? ?????? ???? 2<br><% }
	String month2 = request.getParameter("month2");
	if (month2==null) { %>?? ?????? ????? 2<br><% }
	String year2 = request.getParameter("year2");
	if (year2==null) { %>?? ?????? ??? 2<br><% }
	
	if ( (ks==null && obl==null) || point==null 
			|| day1==null || month1==null || year1==null
			|| day2==null || month2==null || year2==null ) { return; }

	if (point.equals("0")) {
		cc.loadDataRangeZero(ks, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, "on");
	} else {
		cc.loadDataRange(point, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, "on");
	}
	
	double max_qua = 0;
	double max_gen = 0;
	
	for (int i=1; i<cc.DataRangeSize(); i++) {
		if ( Math.abs(cc.getDataRangeByNameDouble(i,"q_qua_1")) > max_qua ) {
			max_qua = Math.abs(cc.getDataRangeByNameDouble(i,"q_qua_1"));
		}
		if ( Math.abs(cc.getDataRangeByNameDouble(i,"q_qua_2")) > max_qua ) {
			max_qua = Math.abs(cc.getDataRangeByNameDouble(i,"q_qua_2"));
		}
		if ( Math.abs(cc.getDataRangeByNameDouble(i,"q_qua_3")) > max_qua ) {
			max_qua = Math.abs(cc.getDataRangeByNameDouble(i,"q_qua_3"));
		}

		if ( Math.abs(cc.getDataRangeByNameDouble(i,"q_gen_1")) > max_gen ) {
			max_gen = Math.abs(cc.getDataRangeByNameDouble(i,"q_gen_1"));
		}
		if ( Math.abs(cc.getDataRangeByNameDouble(i,"q_gen_2")) > max_gen ) {
			max_gen = Math.abs(cc.getDataRangeByNameDouble(i,"q_gen_2"));
		}
		if ( Math.abs(cc.getDataRangeByNameDouble(i,"q_gen_3")) > max_gen ) {
			max_gen = Math.abs(cc.getDataRangeByNameDouble(i,"q_gen_3"));
		}
	}
	long scale_qua = 10;
	long scale_gen = 10;
	float fullscale_qua = 10;
	float fullscale_gen = 10;
	float step_qua = 1;
	float step_gen = 1;

	while ( max_qua / scale_qua > 10 ) scale_qua *= 10;
	step_qua = (int)(max_qua / scale_qua)+1;
	fullscale_qua = step_qua*scale_qua;

	while ( max_gen / scale_gen > 10 ) scale_gen *= 10;
	step_gen = (int)(max_gen / scale_gen)+1;
	fullscale_gen = step_gen*scale_gen;

	
	double vpp_qua = max_qua==0?200:200/(double)fullscale_qua;
	double vpp_gen = max_gen==0?200:200/(double)fullscale_gen;


	int sh_x = 20;
	int w = sh_x+cc.DataRangeSize()*42+20;
	int h = 500;

    try {
		//u.p("starting to do an image");
        // prepare some output
        BufferedImage buffer = new BufferedImage(w,h,BufferedImage.TYPE_INT_RGB);
        Graphics g = buffer.createGraphics();

        Font font = Font.createFont(Font.TRUETYPE_FONT,
                new FileInputStream(this.getServletContext().getRealPath("../../shared/fonts/tahoma.ttf")));
        Font fontb = Font.createFont(Font.TRUETYPE_FONT,
                new FileInputStream(this.getServletContext().getRealPath("../../shared/fonts/tahomabd.ttf")));
        float size = 12.0f;
        font = font.deriveFont(size);
        fontb = fontb.deriveFont(size);
		g.setFont(font);

		g.setColor(Color.WHITE);
		g.fillRect(0,0,w,h);

		g.setColor(Color.GRAY);
        g.drawRect(0,0,w-1,h-1);
       
		for (int i=1; i<cc.DataRangeSize(); i++) {
			g.setColor(new Color(Integer.parseInt(z1,16)));
			g.fillRect(-42+28+sh_x+i*42+1*14,40,14,200);
			g.fillRect(-42+28+sh_x+i*42+1*14,260,14,200);
			g.setColor(new Color(Integer.parseInt(z2,16)));
			g.fillRect(-42+28+sh_x+i*42+2*14,40,14,200);
			g.fillRect(-42+28+sh_x+i*42+2*14,260,14,200);
			g.setColor(new Color(Integer.parseInt(z3,16)));
			g.fillRect(-42+28+sh_x+i*42+3*14,40,14,200);
			g.fillRect(-42+28+sh_x+i*42+3*14,260,14,200);
			g.setColor(Color.BLACK);
			g.drawString(cc.getDataRangeByName(cc.DataRangeSize()-i,"dat").substring(0,5),sh_x+7+i*42,255);

			for (int j=1; j<= step_qua; j++) {
				g.setColor(Color.LIGHT_GRAY);
				g.drawLine(sh_x+i*42,Math.round(240-j*(200/step_qua)),sh_x+(i+1)*42,Math.round(240-j*(200/step_qua)));
				g.setColor(Color.BLACK);
				g.drawLine(sh_x+37,Math.round(240-j*(200/step_qua)),sh_x+42,Math.round(240-j*(200/step_qua)));
				str = Basic.formatNumber(1,10,0,0,(double)(scale_qua*j));
				g.drawString(str,sh_x+33-str.length()*7,Math.round(240+4-j*(200/step_qua)));
			}

			for (int j=1; j<= step_gen; j++) {
				g.setColor(Color.LIGHT_GRAY);
				g.drawLine(sh_x+i*42,Math.round(260+j*(200/step_gen)),sh_x+(i+1)*42,Math.round(260+j*(200/step_gen)));
				g.setColor(Color.BLACK);
				g.drawLine(sh_x+37,Math.round(260+j*(200/step_gen)),sh_x+42,Math.round(260+j*(200/step_gen)));
				str = Basic.formatNumber(1,10,0,0,(double)(scale_gen*j));
				g.drawString(str,sh_x+33-str.length()*7,Math.round(260+4+j*(200/step_gen)));
			}

			
			g.setColor(new Color(Integer.parseInt(colr_qua,16)));
			g.fillRect(sh_x+4+i*42+0*14,240-(int)Math.round(Math.abs(cc.getDataRangeByNameDouble(cc.DataRangeSize()-i,"q_qua_1"))*vpp_qua),6,(int)Math.round(Math.abs(cc.getDataRangeByNameDouble(cc.DataRangeSize()-i,"q_qua_1"))*vpp_qua));
			g.setColor(new Color(Integer.parseInt(colr_gen,16)));
			g.fillRect(sh_x+4+i*42+0*14,260,6,(int)(Math.abs(cc.getDataRangeByNameDouble(cc.DataRangeSize()-i,"q_gen_1"))*vpp_gen));

			g.setColor(new Color(Integer.parseInt(colr_qua,16)));
			g.fillRect(sh_x+4+i*42+1*14,240-(int)Math.round(Math.abs(cc.getDataRangeByNameDouble(cc.DataRangeSize()-i,"q_qua_2"))*vpp_qua),6,(int)Math.round(Math.abs(cc.getDataRangeByNameDouble(cc.DataRangeSize()-i,"q_qua_2"))*vpp_qua));
			g.setColor(new Color(Integer.parseInt(colr_gen,16)));
			g.fillRect(sh_x+4+i*42+1*14,260,6,(int)(Math.abs(cc.getDataRangeByNameDouble(cc.DataRangeSize()-i,"q_gen_2"))*vpp_gen));

			g.setColor(new Color(Integer.parseInt(colr_qua,16)));
			g.fillRect(sh_x+4+i*42+2*14,240-(int)Math.round(Math.abs(cc.getDataRangeByNameDouble(cc.DataRangeSize()-i,"q_qua_3"))*vpp_qua),6,(int)Math.round(Math.abs(cc.getDataRangeByNameDouble(cc.DataRangeSize()-i,"q_qua_3"))*vpp_qua));
			g.setColor(new Color(Integer.parseInt(colr_gen,16)));
			g.fillRect(sh_x+4+i*42+2*14,260,6,(int)(Math.abs(cc.getDataRangeByNameDouble(cc.DataRangeSize()-i,"q_gen_3"))*vpp_gen));

			
			g.setColor(Color.BLACK);
			g.drawRect(sh_x+i*42,240,42,20);
			g.drawRect(sh_x+i*42,40,42,200);
			g.drawRect(sh_x+i*42,260,42,200);
		}

//		g.setColor(Color.LIGHT_GRAY);
//		g.drawString(Basic.formatNumber(1,10,2,2,max_qua),140,20);
//		g.drawString(Basic.formatNumber(1,10,2,2,max_gen),80,20);

        g.setColor(Color.BLACK);
		g.setFont(fontb);
		g.drawString("\u043A\u0432\u0430\u0440\u00B7\u0433",sh_x-5,17); //????*?
		g.drawString("\u0434\u043D\u0456",sh_x+10,255); //???
		g.drawString("\u043A\u0432\u0430\u0440\u00B7\u0433",sh_x-5,492); //????*?

		g.drawLine(sh_x+42,10,sh_x+42,240); //y+
		g.drawLine(sh_x+42,10,sh_x+44,20); //arrow +
		g.drawLine(sh_x+42,10,sh_x+40,20); //arrow +
//		g.drawString("R+",28,20); // R+
		
		g.drawLine(sh_x+42,260,sh_x+42,490); //y-
		g.drawLine(sh_x+42,490,sh_x+44,480); //arrow -
		g.drawLine(sh_x+42,490,sh_x+40,480); //arrow -
//		g.drawString("R-",28,390); // R-

        // set the content type and get the output stream
        response.setContentType("image/png");
        OutputStream os = response.getOutputStream();
        // output the image as pnt
        ImageIO.write(buffer, "png", os);
        // output the image as a jpeg
        os.close();
    } catch (Exception ex) {
        u.p(ex);
    }
%>
