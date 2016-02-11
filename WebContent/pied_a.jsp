<%@ page import="java.io.*" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.awt.image.*" %>
<%@ page import="org.joshy.*" %>
<%@ page import="javax.imageio.*" %>
<%@ page import="ua.datapark.commons.Basic" %>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._Range"/>
<%
	String z0 = "EEEEEE";
	String z1 = "169CFF";
	String z2 = "FFFB5E";
	String z3 = "FF5454";

	String bg = "FAFAFA";

	int w = 680;
	int h = 300;
	int sh_x = 230;
	int sh_y = 50;

	int d = 200;
	int sh_d = 30;
	int sh_text = 0;

	String ks = request.getParameter("ks");
	String obl = request.getParameter("obl");
	if (ks==null && obl==null) { %>no object<br><%  }
	String point = request.getParameter("point");
	if (point==null) { %>no point<br><%  }

	String day = request.getParameter("day");
	if (day==null) { %>no day<br><% }
	String month = request.getParameter("month");
	if (month==null) { %>no month<br><% }
	String year = request.getParameter("year");
	if (year==null) { %>no year<br><% }

	if ( (ks==null && obl==null) || point==null || day==null || month==null || year==null) { return; }

	if (point.equals("0")) {
		cc.loadDataRangeZero(ks, year+"-"+month+"-"+day, year+"-"+month+"-"+day, "on");
	} else {
		cc.loadDataRange(point, year+"-"+month+"-"+day, year+"-"+month+"-"+day, "on");
	}
	float z1_val = 0;
	float z2_val = 0;
	float z3_val = 0;
	
    try {
        BufferedImage buffer = new BufferedImage(w,h,BufferedImage.TYPE_INT_RGB);
        Graphics g = buffer.createGraphics();

        Font font = Font.createFont(Font.TRUETYPE_FONT,
                new FileInputStream(this.getServletContext().getRealPath("../../shared/fonts/tahoma.ttf")));
        float size = 12.0f;
        font = font.deriveFont(size);
		g.setFont(font);

		g.setColor(new Color(Integer.parseInt(bg,16)));
		g.fillRect(0,0,w,h);
		g.setColor(Color.BLACK);
		g.drawRect(0,0,w-1,h-1);

		z1_val = Math.abs((float)cc.getDataRangeByNameDouble(0,"p_qua_1"));
		z2_val = Math.abs((float)cc.getDataRangeByNameDouble(0,"p_qua_2"));
		z3_val = Math.abs((float)cc.getDataRangeByNameDouble(0,"p_qua_3"));
		
		float z_sum = z1_val + z2_val + z3_val;
		float angle;
		
		if (!(z_sum==0)) {
			int last = 0;
			g.setColor(new Color(Integer.parseInt(z1,16)));
			angle =  (float)Math.toRadians(-(last + 360*z1_val/z_sum/2)) ;
			if (Math.abs(-(last + 360*z1_val/z_sum/2))>90 && Math.abs(-(last + 360*z1_val/z_sum/2))>270) sh_text = 163; else sh_text = 0;
			g.fillArc(sh_x+0,sh_y+0,d-1,d-1,last,(int)Math.round(360*z1_val/z_sum));
			if (z1_val > 0) {
				g.setColor(Color.BLACK);
				g.drawLine(Math.round(sh_x+d/2-1+(d/2)*(float)Math.cos(angle)),
							Math.round(sh_y+d/2-1+(d/2)*(float)Math.sin(angle)),
							Math.round(sh_x+d/2+(d/2+sh_d)*(float)Math.cos(angle)),
							Math.round(sh_y+d/2+(d/2+sh_d)*(float)Math.sin(angle)));
				g.drawLine(Math.round(-sh_text+sh_x+d/2+(d/2+sh_d)*(float)Math.cos(angle)),
							Math.round(sh_y+d/2+(d/2+sh_d)*(float)Math.sin(angle)),
							Math.round(-sh_text+163+sh_x+d/2+(d/2+sh_d)*(float)Math.cos(angle)),
							Math.round(sh_y+d/2+(d/2+sh_d)*(float)Math.sin(angle)));
				g.drawString("\u0422\u0430\u0440\u0438\u0444 1 (\u043D\u0456\u0447\u043D\u0438\u0439) "+Basic.formatNumber(1,3,2,2,100*z1_val/z_sum)+" %",
								-sh_text+5+Math.round(sh_x+d/2-1+(d/2+sh_d)*(float)Math.cos(angle)),
								-1+Math.round(sh_y-1+d/2+(d/2+sh_d)*(float)Math.sin(angle)));
			}
			
			last += 360*z1_val/z_sum;
			
			g.setColor(new Color(Integer.parseInt(z2,16)));
			angle = (float)Math.toRadians(-(last + 360*z2_val/z_sum/2)) ;
			if ( Math.abs(-(last + 360*z2_val/z_sum/2))> 90 && Math.abs(-(last + 360*z2_val/z_sum/2))< 270) sh_text = 173; else sh_text = 0;
			g.fillArc(sh_x+0,sh_y+0,d-1,d-1,last,(int)Math.round(360*z2_val/z_sum));
			if (z2_val > 0) {
				g.setColor(Color.BLACK);
				g.drawLine(Math.round(sh_x+d/2-1+(d/2)*(float)Math.cos(angle)),
						Math.round(sh_y+d/2-1+(d/2)*(float)Math.sin(angle)),
						Math.round(sh_x+d/2+(d/2+sh_d)*(float)Math.cos(angle)),
						Math.round(sh_y+d/2+(d/2+sh_d)*(float)Math.sin(angle)));
				g.drawLine(Math.round(-sh_text+sh_x+d/2+(d/2+sh_d)*(float)Math.cos(angle)),
						Math.round(sh_y+d/2+(d/2+sh_d)*(float)Math.sin(angle)),
						Math.round(-sh_text+173+sh_x+d/2+(d/2+sh_d)*(float)Math.cos(angle)),
						Math.round(sh_y+d/2+(d/2+sh_d)*(float)Math.sin(angle)));
				g.drawString("\u0422\u0430\u0440\u0438\u0444 2 (\u043D\u0430\u043F\u0456\u0432\u043F\u0456\u043A.) "+Basic.formatNumber(1,3,2,2,100*z2_val/z_sum)+" %",
						-sh_text+5+Math.round(sh_x+d/2-1+(d/2+sh_d)*(float)Math.cos(angle)),
						-1+Math.round(sh_y-1+d/2+(d/2+sh_d)*(float)Math.sin(angle)));
			}

			last += 360*z2_val/z_sum;

			g.setColor(new Color(Integer.parseInt(z3,16)));
			angle = (float)Math.toRadians(- (last + (360-last)/2));
			if (Math.abs(-(last + (360-last)/2))>90 && Math.abs(-(last + (360-last)/2))<270) sh_text = 170; else sh_text = 0;
			g.fillArc(sh_x+0,sh_y+0,d-1,d-1,last,360-last);
			if (z3_val > 0) {
				g.setColor(Color.BLACK);
				g.drawLine(Math.round(sh_x+d/2-1+(d/2)*(float)Math.cos(angle)),
						Math.round(sh_y+d/2-1+(d/2)*(float)Math.sin(angle)),
						Math.round(sh_x+d/2+(d/2+sh_d)*(float)Math.cos(angle)),
						Math.round(sh_y+d/2+(d/2+sh_d)*(float)Math.sin(angle)));
				g.drawLine(Math.round(-sh_text+sh_x+d/2+(d/2+sh_d)*(float)Math.cos(angle)),
						Math.round(sh_y+d/2+(d/2+sh_d)*(float)Math.sin(angle)),
						Math.round(-sh_text+170+sh_x+d/2+(d/2+sh_d)*(float)Math.cos(angle)),
						Math.round(sh_y+d/2+(d/2+sh_d)*(float)Math.sin(angle)));
				g.drawString("\u0422\u0430\u0440\u0438\u0444 3 (\u043F\u0456\u043A\u043E\u0432\u0438\u0439) "+Basic.formatNumber(1,3,2,2,100*z3_val/z_sum)+" %",
						-sh_text+5+Math.round(sh_x+d/2-1+(d/2+sh_d)*(float)Math.cos(angle)),
						-1+Math.round(sh_y-1+d/2+(d/2+sh_d)*(float)Math.sin(angle)));
			}

			g.setColor(Color.BLACK);
			g.drawOval(sh_x+0,sh_y+0,d-1,d-1);
		} else {
			g.setColor(Color.BLACK);
			g.drawString("\u043d\u0443\u043b\u044c\u043e\u0432\u0456\u00a0"+
						"\u0434\u0430\u043d\u0456",320,150);
		}

		g.setColor(Color.BLACK);
//		g.drawString("A+",12,15);

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
