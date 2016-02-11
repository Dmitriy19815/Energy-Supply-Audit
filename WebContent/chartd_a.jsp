<%@ page import="java.io.*" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.awt.image.*" %>
<%@ page import="org.joshy.*" %>
<%@ page import="javax.imageio.*" %>
<%@ page import="ua.datapark.commons.Basic" %>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._RangeDay"/>
<%
	String colr_qua = "49BF2C";

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
	String day = request.getParameter("day");
	if (day==null) { day=""; }
	String month = request.getParameter("month");
	if (month==null) { %>no month<br><% }
	String year = request.getParameter("year");
	if (year==null) { %>no year<br><% }

	if ( (ks==null && obl==null) || point==null || month==null || year==null) { return; }

	if (point.equals("0")) {
		cc.loadDataZeroDay(ks, day+"-"+month+"-"+year, "on");
	} else {
		cc.loadDataDay(point, day+"-"+month+"-"+year, "on");
	}

	double max_qua = 0;
	
	for (int i=0; i<cc.DataDaySize(); i++) {
		if ( Math.abs(cc.getDataDayByNameDouble(i,"p_qua_0")) > max_qua ) {
			max_qua = Math.abs(cc.getDataDayByNameDouble(i,"p_qua_0"));
		}
	}
	
	long scale_qua = 10;
	float fullscale_qua = 10;
	float step_qua = 1;
	
	while ( max_qua / scale_qua > 10 ) scale_qua *= 10;
	step_qua = (int)(max_qua / scale_qua)+1;
	fullscale_qua = step_qua*scale_qua;

	double vpp_qua = max_qua==0?200:200/(double)fullscale_qua;

	int w = 760;
	int h = 270;
	int sh_x = 20;

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

		boolean parity = true;
		String colr = "";
		int Day = 0;
		for (int i=0; i<49; i++) {
			for (int j=cc.DataDaySize()-1; j>=0; j--) {
				Day=Integer.parseInt(cc.getDataDayByName(j,"h"));
				if (Day==i) {
					colr="aaaaaa";
					if (cc.getDataDayByName(j,"zval").equals("1")) colr=z1;
					if (cc.getDataDayByName(j,"zval").equals("2")) colr=z2;
					if (cc.getDataDayByName(j,"zval").equals("3")) colr=z3;
					g.setColor(new Color(Integer.parseInt(colr,16)));
					g.fillRect(sh_x+29+Day*14,40,13,200);
				}
			}
		}
		
		for (int i=1; i <= step_qua; i++) {
			g.setColor(Color.LIGHT_GRAY);
			g.drawLine(sh_x+42,Math.round(240-i*(200/step_qua)),sh_x+42+48*14,Math.round(240-i*(200/step_qua)));
	        g.setColor(Color.BLACK);
			g.drawLine(sh_x+37,Math.round(240-i*(200/step_qua)),sh_x+42,Math.round(240-i*(200/step_qua)));
			
			str = Basic.formatNumber(1,10,0,0,scale_qua*i);
			g.drawString(str,sh_x+35-str.length()*7,Math.round(240+4-i*(200/step_qua)));
		}
        g.setColor(Color.BLACK);
		g.drawLine(sh_x+37,240,sh_x+42,240);
		
		Day = 0;
		for (int i=0; i<49; i++) {
			for (int j=cc.DataDaySize()-1; j>=0; j--) {
				Day=Integer.parseInt(cc.getDataDayByName(j,"h"));
				if (Day==i) {
					colr="aaaaaa";
					if (cc.getDataDayByName(j,"zval").equals("1")) colr=z1;
					if (cc.getDataDayByName(j,"zval").equals("2")) colr=z2;
					if (cc.getDataDayByName(j,"zval").equals("3")) colr=z3;
					g.setColor(new Color(Integer.parseInt(colr_qua,16)));
					g.fillRect(sh_x+4+28+Day*14,240-(int)Math.round(Math.abs(cc.getDataDayByNameDouble(j,"p_qua_0"))*vpp_qua),6,(int)Math.round(Math.abs(cc.getDataDayByNameDouble(j,"p_qua_0"))*vpp_qua));
				}
			}
		}
		
		for (int i=0; i<48; i++) {
			if (parity) {
				g.setColor(Color.LIGHT_GRAY);
				//g.drawLine(31+i*12,10,31+i*12,390);
				g.setColor(Color.BLACK);
				g.drawString(Basic.formatNumber(2,2,0,0,i/2),sh_x+51+i*14,255); // 16
				g.drawRect(sh_x+42+i*14,240,28,20);
				g.drawRect(sh_x+42+i*14,40,28,200);
			}
			if (parity) parity = false; else parity = true;
		}
		
//		g.setColor(Color.LIGHT_GRAY);
//		g.drawString(Basic.formatNumber(1,10,2,2,max_qua),420,20);
//		g.drawString(Basic.formatNumber(1,10,2,2,max_gen),520,20);

        g.setColor(Color.BLACK);
		g.setFont(fontb);
		g.drawString("\u043A\u0412\u0442\u00B7\u0433",sh_x-5,17);
		g.drawString("\u0433\u043E\u0434\u0438\u043D\u0438",sh_x-10,255);

		g.drawLine(sh_x+42,10,sh_x+42,240); //y+
		g.drawLine(sh_x+42,10,sh_x+44,20); //arrow +
		g.drawLine(sh_x+42,10,sh_x+40,20); //arrow +
	
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
