<%@ page import="java.io.*" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.awt.image.*" %>
<%@ page import="org.joshy.*" %>
<%@ page import="javax.imageio.*" %>
<%@ page import="ua.datapark.commons.Basic" %>
<%@ page import="ua.datapark.audit.DataVector" %>
<%@ page import="java.util.*;" %>
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<jsp:useBean id="crp" scope="page" class="ua.datapark.audit._RangePoint"/>
<jsp:useBean id="cr" scope="page" class="ua.datapark.audit._Range"/>
<%
	String bg = "FAFAFA";

	int w = 680;
	int h = 320;
	int sh_x = 90;
	int sh_y = 60;

	int d = 200;
	int sh_d = 40;
	int sh_text = 0;

	String ks = request.getParameter("ks");
	String obl = request.getParameter("obl");
	if (ks==null && obl==null) { %>no object<br><%  }
	String point = request.getParameter("point");
	if (point==null) { %>no point<br><%  }
	
	String day1 = request.getParameter("day1");
	String month1 = request.getParameter("month1");
	String year1 = request.getParameter("year1");

	String day2 = request.getParameter("day2");
	String month2 = request.getParameter("month2");
	String year2 = request.getParameter("year2");
	
	if ( (ks==null && obl==null) || point==null 
			|| day1==null || month1==null || year1==null
			|| day2==null || month2==null || year2==null ) { return; }	

	if (point.equals("0")) {
		cr.loadDataRangeZero(ks, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, "on");
	} else {
		cr.loadDataRange(point, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, "on");
	}

	crp.loadDataRangeZeroAll(ks, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, "on");
	
	ArrayList ar = crp.getDataRangePoint(0); 

	String point_name[] = new String[ar.size()-1];
	double val[] = new double[ar.size()-1];
	String proc[] = new String[ar.size()-1];
	long segment[] = new long[ar.size()-1];
	long seg_start[] = new long[ar.size()-1];
	long seg_middle[] = new long[ar.size()-1];
	String colors[] = {"3399FF","FF6363","FFFB5E","2FC336","FC81FF","74FFDC"};
	double val_sum = 0;

	for (int i=0; i<ar.size()-1; i++) {
		DataVector dv = (DataVector) ar.get(i+1);
		point_name[i] = c.getPointName(dv.point_id);
		val[i] = Math.abs(dv.getByNameDouble("p_qua_0"));
		val_sum += val[i];
	}
	
	long last = 0;
	for (int i=0; i<val.length; i++) {
		proc[i] = Basic.formatNumber(1,3,3,3,val[i]/val_sum*100)+" %";
		segment[i] = Math.round(360*val[i]/val_sum);
		seg_start[i] = last;
		seg_middle[i] = last + Math.round(360*val[i]/val_sum/2);
		last += segment[i];
	}
	
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
        
		int cl = 0;
		float angle = 0;
		for (int i=0; i<val.length; i++) {
			if (segment[i]>0) {
				g.setColor(new Color(Integer.parseInt(colors[cl % colors.length],16)));
				g.fillArc(sh_x+0,sh_y+0,d-1,d-1,(int)seg_start[i],(int)segment[i]);
				
				if ( Math.abs(-seg_middle[i])>90 && Math.abs(-seg_middle[i])<270 )sh_text = 20; else sh_text = 0;
				g.setColor(Color.BLACK);
				angle = (float)Math.toRadians(-seg_middle[i]);
				g.drawLine(Math.round(sh_x+d/2-1+(d/2)*(float)Math.cos(angle)),
							Math.round(sh_y+d/2-1+(d/2)*(float)Math.sin(angle)),
							Math.round(sh_x+d/2+(d/2+sh_d)*(float)Math.cos(angle)),
							Math.round(sh_y+d/2+(d/2+sh_d)*(float)Math.sin(angle)));
				g.drawLine(Math.round(-sh_text+sh_x+d/2+(d/2+sh_d)*(float)Math.cos(angle)),
							Math.round(sh_y+d/2+(d/2+sh_d)*(float)Math.sin(angle)),
							Math.round(-sh_text+20+sh_x+d/2+(d/2+sh_d)*(float)Math.cos(angle)),
							Math.round(sh_y+d/2+(d/2+sh_d)*(float)Math.sin(angle)));
				g.drawString(String.valueOf(i+1),
						-sh_text+5+Math.round(sh_x+d/2-1+(d/2+sh_d)*(float)Math.cos(angle)),
						-1+Math.round(sh_y-1+d/2+(d/2+sh_d)*(float)Math.sin(angle)));

				g.setColor(new Color(Integer.parseInt(colors[cl % colors.length],16)));
				g.fillRect(sh_x+293,15+i*20,10,10);
				cl++;
			}

			g.setColor(Color.BLACK);
			g.drawRect(sh_x+293,15+i*20,10,10);
			g.drawString((i+1)+". "+point_name[i]+" ("+proc[i]+")",sh_x+310,25+i*20);
			
		}
		
		
		g.setColor(Color.BLACK);
		g.drawOval(sh_x,sh_y,d-1,d-1);

//		g.setColor(Color.BLACK);
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
