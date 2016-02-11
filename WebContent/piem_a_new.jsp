<%@ page import="java.io.*" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.awt.image.*" %>
<%@ page import="java.awt.geom.*" %>
<%@ page import="org.joshy.*" %>
<%@ page import="javax.imageio.*" %>

<%@ page import="org.jfree.chart.*" %>
<%@ page import="org.jfree.data.*" %>
<%@ page import="org.jfree.chart.plot.*" %>

<%@ page import="ua.datapark.commons.Basic" %>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._Range" />
<%
	//String z0 = "EEEEEE";
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
		cc.loadDataRangeZero(ks, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, "on");
	} else {
		cc.loadDataRange(point, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, "on");
	}

	float z1_val = 0;
	float z2_val = 0;
	float z3_val = 0;
	
    try {
        String name = "name";
        
        DefaultPieDataset dataset = new DefaultPieDataset();
        dataset.setValue("revenue",12);
        dataset.setValue("cost",44);
        //highlightSyntax("javaMjVmNT","java");
        
        JFreeChart pieChart = ChartFactory.createPieChart3D(name, dataset, true, true, false);
		PiePlot3D plot = (PiePlot3D)pieChart.getPlot();
		plot.setForegroundAlpha(0.40f);
		
//		BufferedImage image = new BufferedImage(380, 270, BufferedImage.SCALE_DEFAULT);
//		Graphics2D g = image.createGraphics();
		//labelGraphik.setIcon(new ImageIcon(image));
    	
    	
        BufferedImage buffer = new BufferedImage(w,h,BufferedImage.TYPE_INT_RGB);
        Graphics2D g = buffer.createGraphics();
		pieChart.draw(g, new Rectangle2D.Double(40, 40, 380, 270), null, null);

//        Font font = Font.createFont(Font.TRUETYPE_FONT,
//                new FileInputStream(this.getServletContext().getRealPath("../../shared/fonts/tahoma.ttf")));
//        float size = 12.0f;
//        font = font.deriveFont(size);
//		g.setFont(font);

//		g.setColor(new Color(Integer.parseInt(bg,16)));
//		g.fillRect(0,0,w,h);
//		g.setColor(Color.BLACK);
//		g.drawRect(0,0,w-1,h-1);
        

		float z_sum = z1_val + z2_val + z3_val;
		float angle;
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
