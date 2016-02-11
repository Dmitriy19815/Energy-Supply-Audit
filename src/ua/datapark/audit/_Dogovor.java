package ua.datapark.audit;

import java.util.ArrayList;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

import ua.datapark.commons.Basic;
import ua.datapark.db.DatabaseTon;

public class _Dogovor {
	DataSource ds;
	AuditNSI au;
	String query = "";
	String processingtime = "";
	
	ArrayList<Dogovor> Dogovors = new ArrayList<Dogovor>();
	ArrayList<DogovorLoss> DogovorLosses = new ArrayList<DogovorLoss>();
	
	Dogovor dg = new Dogovor();
	
	public _Dogovor() {
		ds = DatabaseTon.getInstance().getDataSource();
		au = AuditNSI.getInstance();
	}

	public String loadDogovorAll(String dogov_id) {
		String value = "";
		Dogovor tempDogovor;
		DogovorLoss tempDogovorLoss;
		
		long stime = System.currentTimeMillis();
		
		try {
			Connection conn = ds.getConnection();
			Statement st = conn.createStatement();
//	    	st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");
			
			if (dogov_id.equals("all")) {
				query = "select id, nomer, ks_id, ks_name, obl_id, obl_name, " +
					" to_char(dat_podpis,'dd-mm-yyyy') d_p, to_char(dat_start,'dd-mm-yyyy') d_s, to_char(dat_end,'dd-mm-yyyy') d_e, days from o$dogovor";
			} else { 
				query = "select id, nomer, ks_id, ks_name, obl_id, obl_name, " +
				" to_char(dat_podpis,'dd-mm-yyyy'), to_char(dat_start,'dd-mm-yyyy'), to_char(dat_end,'dd-mm-yyyy'), days from o$dogovor " +
				"WHERE dogov_id="+dogov_id;
			}
			ResultSet rs = st.executeQuery(query);
			Dogovors.clear();
			
			while (rs.next()){
				tempDogovor = new Dogovor();
				
				tempDogovor.dogov_id =  rs.getInt("id");
				tempDogovor.nomer =  rs.getString("nomer");
				tempDogovor.ks_id =  rs.getInt("ks_id");
				tempDogovor.ks_name =  rs.getString("ks_name");
				tempDogovor.obl_id =  rs.getInt("obl_id");
				tempDogovor.obl_name =  rs.getString("obl_name");
				tempDogovor.dat_podpis =  rs.getString("d_p");
				tempDogovor.dat_start =  rs.getString("d_s");
				tempDogovor.dat_end =  rs.getString("d_e");
				tempDogovor.days =  rs.getInt("days");
	
				Dogovors.add(tempDogovor);
			}
			tempDogovor = null;
			
			query = "select dogov_loss_id, dogov_id, dogovor_nomer, to_char(dogovor_dat_podpis,'dd.mm.yyyy') dd, " +
			"point_id, point_name, " +
			"loss_fixed_sa_1, loss_fixed_sa_2, loss_fixed_sa_3, " +
			"loss_fixed_sr_1, loss_fixed_sr_2, loss_fixed_sr_3, " +
			"loss_fixed_gr_1, loss_fixed_gr_2, loss_fixed_gr_3, " +
			"loss_float_sa_1, loss_float_sa_2, loss_float_sa_3, " +
			"loss_float_sr_1, loss_float_sr_2, loss_float_sr_3, " +
			"loss_float_gr_1, loss_float_gr_2, loss_float_gr_3 " +
			"from o$dogov_loss";
			
			rs = st.executeQuery(query);
			DogovorLosses.clear();

			while (rs.next()) {
				tempDogovorLoss = new DogovorLoss();

				tempDogovorLoss.dogov_loss_id =  rs.getInt("dogov_loss_id");
				tempDogovorLoss.dogov_id =  rs.getInt("dogov_id");
				tempDogovorLoss.dogovor_nomer =  rs.getString("dogovor_nomer");
				tempDogovorLoss.dogovor_dat_podpis =  rs.getString("dd");

				tempDogovorLoss.point_id =  rs.getInt("point_id");
				tempDogovorLoss.point_name =  rs.getString("point_name");

				tempDogovorLoss.loss_fixed_sa_1 = rs.getDouble("loss_fixed_sa_1");
				tempDogovorLoss.loss_fixed_sa_2 = rs.getDouble("loss_fixed_sa_2");
				tempDogovorLoss.loss_fixed_sa_3 = rs.getDouble("loss_fixed_sa_3");

				tempDogovorLoss.loss_fixed_sr_1 = rs.getDouble("loss_fixed_sr_1");
				tempDogovorLoss.loss_fixed_sr_2 = rs.getDouble("loss_fixed_sr_2");
				tempDogovorLoss.loss_fixed_sr_3 = rs.getDouble("loss_fixed_sr_3");

				tempDogovorLoss.loss_fixed_gr_1 = rs.getDouble("loss_fixed_gr_1");
				tempDogovorLoss.loss_fixed_gr_2 = rs.getDouble("loss_fixed_gr_2");
				tempDogovorLoss.loss_fixed_gr_3 = rs.getDouble("loss_fixed_gr_3");

				tempDogovorLoss.loss_float_sa_1 = rs.getDouble("loss_float_sa_1");
				tempDogovorLoss.loss_float_sa_2 = rs.getDouble("loss_float_sa_2");
				tempDogovorLoss.loss_float_sa_3 = rs.getDouble("loss_float_sa_3");

				tempDogovorLoss.loss_float_sr_1 = rs.getDouble("loss_float_sr_1");
				tempDogovorLoss.loss_float_sr_2 = rs.getDouble("loss_float_sr_2");
				tempDogovorLoss.loss_float_sr_3 = rs.getDouble("loss_float_sr_3");

				tempDogovorLoss.loss_float_gr_1 = rs.getDouble("loss_float_gr_1");
				tempDogovorLoss.loss_float_gr_2 = rs.getDouble("loss_float_gr_2");
				tempDogovorLoss.loss_float_gr_3 = rs.getDouble("loss_float_gr_3");
				
				DogovorLosses.add(tempDogovorLoss);				
			}
			tempDogovorLoss = null;

			for (int i=0; i< Dogovors.size(); i++) {
				Dogovor d = (Dogovor) Dogovors.get(i);
				for (int j=0; j<DogovorLosses.size(); j++) {
					DogovorLoss dl = (DogovorLoss) DogovorLosses.get(j);
					if (d.dogov_id == dl.dogov_id ) {
						d.points.add(dl);
					}
				}
			}

			rs.close();
		    st.close();
			conn.close();
		} 
		catch (SQLException e) {
			Basic.Logerr("loadDogovorAll error: "+e.getLocalizedMessage());
			value = "SQL Exception";
		} 
		catch (Exception e) {
			Basic.Logerr("loadDogovorAll error: "+e.getLocalizedMessage());
			value = "SQL Exception";
		}
		processingtime = String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
		return value;
	}

	public String loadDogovors(String ks_id, String dat_start, String dat_end) {
		String value = "";
		Dogovor tempDogovor;
		DogovorLoss tempDogovorLoss;
		long stime = System.currentTimeMillis();
		try {
			Connection conn = ds.getConnection();
			Statement st = conn.createStatement();
//	    	st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");
				query = "select id, nomer, ks_id, ks_name, obl_id, obl_name, " +
				" to_char(dat_podpis,'dd-mm-yyyy') d_p, to_char(dat_start,'dd-mm-yyyy') d_s, to_char(dat_end,'dd-mm-yyyy') d_e, days from o$dogovor " +
				"WHERE ks_id="+ks_id+" " +
				"AND to_char(dat_start,'yyyy-mm-dd')>='"+dat_start+"' "+
				"AND to_char(dat_start,'yyyy-mm-dd')<='"+dat_end+"' ";
			ResultSet rs = st.executeQuery(query);
			Dogovors.clear();
			
			while (rs.next()){
				tempDogovor = new Dogovor();
				
				tempDogovor.dogov_id =  rs.getInt("id");
				tempDogovor.nomer =  rs.getString("nomer");
				tempDogovor.ks_id =  rs.getInt("ks_id");
				tempDogovor.ks_name =  rs.getString("ks_name");
				tempDogovor.obl_id =  rs.getInt("obl_id");
				tempDogovor.obl_name =  rs.getString("obl_name");
				tempDogovor.dat_podpis =  rs.getString("d_p");
				tempDogovor.dat_start =  rs.getString("d_s");
				tempDogovor.dat_end =  rs.getString("d_e");
				tempDogovor.days =  rs.getInt("days");
	
				Dogovors.add(tempDogovor);
			}
			tempDogovor = null;
			
			query = "select dogov_loss_id, dogov_id, dogovor_nomer, to_char(dogovor_dat_podpis,'dd.mm.yyyy') dd, " +
			"point_id, point_name, " +
			"loss_fixed_sa_1, loss_fixed_sa_2, loss_fixed_sa_3, " +
			"loss_fixed_sr_1, loss_fixed_sr_2, loss_fixed_sr_3, " +
			"loss_fixed_gr_1, loss_fixed_gr_2, loss_fixed_gr_3, " +
			"loss_float_sa_1, loss_float_sa_2, loss_float_sa_3, " +
			"loss_float_sr_1, loss_float_sr_2, loss_float_sr_3, " +
			"loss_float_gr_1, loss_float_gr_2, loss_float_gr_3 " +
			"from o$dogov_loss";
			
			rs = st.executeQuery(query);
			DogovorLosses.clear();

			while (rs.next()){
				tempDogovorLoss= new DogovorLoss();
				
				tempDogovorLoss.dogov_loss_id =  rs.getInt("dogov_loss_id");
				tempDogovorLoss.dogov_id =  rs.getInt("dogov_id");
				tempDogovorLoss.dogovor_nomer =  rs.getString("dogovor_nomer");
				tempDogovorLoss.dogovor_dat_podpis =  rs.getString("dd");

				tempDogovorLoss.point_id =  rs.getInt("point_id");
				tempDogovorLoss.point_name =  rs.getString("point_name");

				tempDogovorLoss.loss_fixed_sa_1 = rs.getDouble("loss_fixed_sa_1");
				tempDogovorLoss.loss_fixed_sa_2 = rs.getDouble("loss_fixed_sa_2");
				tempDogovorLoss.loss_fixed_sa_3 = rs.getDouble("loss_fixed_sa_3");

				tempDogovorLoss.loss_fixed_sr_1 = rs.getDouble("loss_fixed_sr_1");
				tempDogovorLoss.loss_fixed_sr_2 = rs.getDouble("loss_fixed_sr_2");
				tempDogovorLoss.loss_fixed_sr_3 = rs.getDouble("loss_fixed_sr_3");

				tempDogovorLoss.loss_fixed_gr_1 = rs.getDouble("loss_fixed_gr_1");
				tempDogovorLoss.loss_fixed_gr_2 = rs.getDouble("loss_fixed_gr_2");
				tempDogovorLoss.loss_fixed_gr_3 = rs.getDouble("loss_fixed_gr_3");

				tempDogovorLoss.loss_float_sa_1 = rs.getDouble("loss_float_sa_1");
				tempDogovorLoss.loss_float_sa_2 = rs.getDouble("loss_float_sa_2");
				tempDogovorLoss.loss_float_sa_3 = rs.getDouble("loss_float_sa_3");

				tempDogovorLoss.loss_float_sr_1 = rs.getDouble("loss_float_sr_1");
				tempDogovorLoss.loss_float_sr_2 = rs.getDouble("loss_float_sr_2");
				tempDogovorLoss.loss_float_sr_3 = rs.getDouble("loss_float_sr_3");

				tempDogovorLoss.loss_float_gr_1 = rs.getDouble("loss_float_gr_1");
				tempDogovorLoss.loss_float_gr_2 = rs.getDouble("loss_float_gr_2");
				tempDogovorLoss.loss_float_gr_3 = rs.getDouble("loss_float_gr_3");
				
				DogovorLosses.add(tempDogovorLoss);
			}
			tempDogovorLoss = null;

			for (int i=0; i< Dogovors.size(); i++) {
				Dogovor d = (Dogovor) Dogovors.get(i);
				for (int j=0; j<DogovorLosses.size(); j++) {
					DogovorLoss dl = (DogovorLoss) DogovorLosses.get(j);
					if (d.dogov_id == dl.dogov_id ) {
						d.points.add(dl);
					}
				}
			}
			
			rs.close();
		    st.close();
			conn.close();
		} 
		catch (SQLException e) {
			Basic.Logerr("loadDogovors error: "+e.getLocalizedMessage());
			value = "SQL Exception";
		} 
		catch (Exception e) {
			Basic.Logerr("loadDogovors error: "+e.getLocalizedMessage());
			value = "Exception";
		}
		processingtime = String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
		return value;
	}
	
	public String loadDogovor(int dogov_id) {
		String value = "";
		long stime = System.currentTimeMillis();
		try {
			Connection conn = ds.getConnection();
			Statement st = conn.createStatement();
//	    	st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");
			query = "select id, nomer, ks_id, ks_name, obl_id, obl_name, to_char(dat_podpis,'dd-mm-yyyy') d_p, to_char(dat_start,'dd-mm-yyyy') d_s, to_char(dat_end,'dd-mm-yyyy') d_e, days " +
					"from o$dogovor " +
					"WHERE id="+dogov_id;
			ResultSet rs = st.executeQuery(query);
			Dogovors.clear();
			
			while (rs.next()){
				dg.dogov_id =  rs.getInt("id");
				dg.nomer =  rs.getString("nomer");
				dg.ks_id =  rs.getInt("ks_id");
				dg.ks_name =  rs.getString("ks_name");
				dg.obl_id =  rs.getInt("obl_id");
				dg.obl_name =  rs.getString("obl_name");
				dg.dat_podpis =  rs.getString("d_p");
				dg.dat_start =  rs.getString("d_s");
				dg.dat_end =  rs.getString("d_e");
				dg.days =  rs.getInt("days");
			}
			
			rs.close();
		    st.close();
			conn.close();
		} catch (SQLException e) {
			Basic.Logerr("loadDogovor error: "+e.getLocalizedMessage());
			value = "SQL Exception";
		} catch (Exception e) {
			Basic.Logerr("loadDogovor error: "+e.getLocalizedMessage());
			value = "Exception";
		}
		processingtime = String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
		return value;
	}
	
	public String loadDogovor(String ks_id, String obl_id, String dat_start, String dat_end) {
		String value = "";
		long stime = System.currentTimeMillis();
		try {
			Connection conn = ds.getConnection();
			Statement st = conn.createStatement();
//	    	st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");
			query = "select id, nomer, ks_id, ks_name, obl_id, obl_name, to_char(dat_podpis,'dd-mm-yyyy') d_p, to_char(dat_start,'dd-mm-yyyy') d_s, to_char(dat_end,'dd-mm-yyyy') d_e, days " +
					"from o$dogovor " +
					"WHERE ks_id="+ks_id+" "+
							"AND obl_id="+obl_id+" " +
							"AND '"+dat_start+"'>=to_char(dat_start,'yyyy-mm-dd') "+
							"AND '"+dat_end+"'<=to_char(dat_end,'yyyy-mm-dd')";							
			ResultSet rs = st.executeQuery(query);
			Dogovors.clear();
			
			int i = 0;
			while (rs.next()) {
				if (i>0) {
					value="more_than_2_dogovors";
				}
				dg.dogov_id =  rs.getInt("id");
				dg.nomer =  rs.getString("nomer");
				dg.ks_id =  rs.getInt("ks_id");
				dg.ks_name =  rs.getString("ks_name");
				dg.obl_id =  rs.getInt("obl_id");
				dg.obl_name =  rs.getString("obl_name");
				dg.dat_podpis =  rs.getString("d_p");
				dg.dat_start =  rs.getString("d_s");
				dg.dat_end =  rs.getString("d_e");
				dg.days =  rs.getInt("days");
				i++;
			}
			if (i==0) {
				value="no_dogovors";
			}
			
			rs.close();
		    st.close();
			conn.close();
		} 
		catch (SQLException e) {
			Basic.Logerr("loadDogovorByKsOblDat error: "+e.getLocalizedMessage());
			value = "SQL Exception";
		} 
		catch (Exception e) {
			Basic.Logerr("loadDogovorByKsOblDat error: "+e.getLocalizedMessage());
			value = "Exception";
		}
		processingtime=String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
		return value;
	}	
	
    public String createDogovor(Dogovor d) {
    	Connection conn = null;
    	String message = "_";
    	
    	ArrayList<Object> points = au.getPoints(String.valueOf(d.ks_id));
    	for (int i=0; i<points.size(); i++) {
    		if (!String.valueOf(d.obl_id).equals(au.getPointf(i,8))) {
    			points.remove(i);
    		}
    	}

    	try {
	 		conn = ds.getConnection();
		    Statement st = conn.createStatement();
    
		    query = "INSERT INTO oblik_dogovor (nomer,ks_id,obl_id,dat_podpis,dat_start,dat_end) VALUES " +
			"('"+d.nomer+"', "+d.ks_id+", "+d.obl_id+", TO_DATE('"+d.dat_podpis+"', 'dd.mm.yyyy'), TO_DATE('"+d.dat_start+"', 'dd.mm.yyyy'), TO_DATE('"+d.dat_end+"', 'dd.mm.yyyy'))";
		    st.executeUpdate(query);

		    
		
		    for (int i=0; i<points.size(); i++ ) {
		    	Point p = (Point) points.get(i);
			    query = "INSERT INTO oblik_dogov_loss (point_id,dogov_id, " +
			    		"loss_fixed_sa_1, loss_fixed_sa_2, loss_fixed_sa_3, " +
			    		"loss_fixed_sr_1, loss_fixed_sr_2, loss_fixed_sr_3, " +
			    		"loss_fixed_gr_1, loss_fixed_gr_2, loss_fixed_gr_3, " +
			    		"loss_float_sa_1, loss_float_sa_2, loss_float_sa_3, " +
			    		"loss_float_sr_1, loss_float_sr_2, loss_float_sr_3, " +
			    		"loss_float_gr_1, loss_float_gr_2, loss_float_gr_3) " +
	
			    		"VALUES ("+p.point_id+", "+d.dogov_id+", " +
			    		"0, 0, 0, " +
			    		"0, 0, 0, " +
			    		"0, 0, 0, " +
			    		"0, 0, 0, " +
			    		"0, 0, 0, " +
			    		"0, 0, 0)";
				st.executeUpdate(query);
		    }
		    		    
		    st.close();
		    conn.close();
		} 
    	catch (SQLException e) {
			Basic.Logerr("createDogovor error: "+e.getLocalizedMessage());
		} 
    	catch (Exception e) {
			Basic.Logerr("createDogovor error: "+e.getLocalizedMessage());
		}
		return message;
    }

    public String deleteDogovor(int dogov_id) {
    	Connection conn = null;
    	String message = "_";
    	Basic.Log(String.valueOf(dogov_id));
    	try {
	 		conn = ds.getConnection();
		    Statement st = conn.createStatement();
		    // ! MUST BE BATCH DELETING
		    query = "DELETE FROM oblik_dogovor WHERE id=" + dogov_id;
			st.executeUpdate(query);

		    query = "DELETE FROM oblik_dogov_loss WHERE dogov_id=" + dogov_id;
			st.executeUpdate(query);

			st.close();
		    conn.close();
		} 
    	catch (SQLException e) {
			Basic.Logerr("deleteDogovor error: "+e.getLocalizedMessage());
		} 
    	catch (Exception e) {
			Basic.Logerr("deleteDogovor error: "+e.getLocalizedMessage());
		}
		return message;
    }

	public String updateDogovor(Dogovor d) {
    	Connection conn = null;
    	String message = "_";
	 	try {
	 		conn = ds.getConnection();
		    Statement st = conn.createStatement();
		    query = "UPDATE oblik_dogovor SET " +
					"nomer="+d.nomer+", " +
					"ks_id="+d.ks_id+", " +
					"obl_id="+d.obl_id+", " +
					"dat_podpis='"+d.dat_podpis+"', " +
					"dat_start='"+d.dat_start+"', " +
					"dat_end='"+d.dat_end+"' " +
			
    		"WHERE id="+d.dogov_id;
		    
		    st.executeUpdate(query);		 
		    st.close();
		    conn.close();
		} 
	 	catch (SQLException e) {
			Basic.Logerr("updateDogovor error: "+e.getLocalizedMessage());
		} 
	 	catch (Exception e) {
			Basic.Logerr("updateDogovor error: "+e.getLocalizedMessage());
		}
		return message;
    }

	public ArrayList<Dogovor> getDogovors() {
		return Dogovors;
	}
	
	public int getDogovorSize() {
		return Dogovors.size();
	}
	
	public Dogovor getDogovor() {
		return dg;
	}
	
}
