<%@ page import="java.sql.*" %>
<%!
class Mahasiswa {
	
	Connection con;
	
	Mahasiswa(Connection con){
		this.con = con;
	}

	public MahasiswaObject get(String nim) {
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return null;
			}
			String sql = "SELECT * FROM mahasiswa WHERE nim = ?";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setString(1, nim);
				try (java.sql.ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						String nimMahasiswa = rs.getString(1);
						String namaMahasiswa = rs.getString(2);
						int kodeJenisKelamin = rs.getInt(3);
						int kodeProdi = rs.getInt(4);
						String username = rs.getString(5);
						MahasiswaObject mahasiswa = new MahasiswaObject();
						mahasiswa.nama = namaMahasiswa;
						mahasiswa.nim = nimMahasiswa;
						mahasiswa.kode_jenis_kelamin = kodeJenisKelamin;
						mahasiswa.kode_prodi = kodeProdi;
						mahasiswa.username =  username;
						return mahasiswa;
					}
				}
			} finally {
				try { if (con != null && !con.isClosed()) con.close(); } catch (Exception ignored) {}
			}
					} catch (Exception e) {
						e.printStackTrace();
						return null;       
			}
		// default: not authenticated
		return null;
	}

	public boolean insert(MahasiswaObject mahasiswa){
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return false;
			}
			String sql = "INSERT INTO mahasiswa (nama, nim, kode_jenis_kelamin, kode_prodi, username) VALUES (?, ?, ?, ?, ?) ";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setString(1, mahasiswa.getNim());
				ps.setString(2, mahasiswa.getNama());
				ps.setInt(3, mahasiswa.getKode_jenis_kelamin());
				ps.setInt(4, mahasiswa.getKode_prodi());
				ps.setString(5, mahasiswa.username);
				int rowsAffected = ps.executeUpdate();
				if (rowsAffected > 0) {
					return true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return false;
	}

	public List<MahasiswaObject> listByKodeRole(int kode_role){
		List<MahasiswaObject> list = new ArrayList<>();
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return list;
			}
			String sql = "SELECT m.* FROM mahasiswa m JOIN user u ON m.username = u.username WHERE u.kode_role = ? ";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setInt(1, kode_role);
				try (java.sql.ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						String namaMahasiswa = rs.getString(2);
						String nimMahasiswa = rs.getString(1);
						int kodeJenisKelamin = rs.getInt(3);
						int kodeProdi = rs.getInt(4);
						String username = rs.getString(5);
						MahasiswaObject mahasiswa = new MahasiswaObject(namaMahasiswa, nimMahasiswa, kodeJenisKelamin, kodeProdi, username);
						list.add(mahasiswa);
					}
				}
			} finally {
				try { if (con != null && !con.isClosed()) con.close(); } catch (Exception ignored) {}
			}
					} catch (Exception e) {
						e.printStackTrace();
						return list;       
			}
		return list;
	}


	public boolean delete(String nim){
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return false;
			}
			String sql = "DELETE FROM mahasiswa WHERE nim = ? ";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setString(1, nim);
				int rowsAffected = ps.executeUpdate();
				if (rowsAffected > 0) {
					return true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;       
			}
		// default: not authenticated
		return false;
	}

	public boolean update(MahasiswaObject mahasiswa){
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return false;
			}
			String sql = "UPDATE mahasiswa SET nama = ?, nim = ?, kode_jenis_kelamin = ?, kode_prodi = ? WHERE kode = ? ";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setString(1, mahasiswa.getNama());
				ps.setString(2, mahasiswa.getNim());
				ps.setInt(3, mahasiswa.getKode_jenis_kelamin());
				ps.setInt(4, mahasiswa.getKode_prodi());
				int rowsAffected = ps.executeUpdate();
				if (rowsAffected > 0) {
					return true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return false;
	}

	public List<MahasiswaObject> list(){
		List<MahasiswaObject> list = new ArrayList<>();
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return list;
			}
			String sql = "SELECT * FROM mahasiswa";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				try (java.sql.ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						String namaMahasiswa = rs.getString(2);
						String nimMahasiswa = rs.getString(1);
						int kodeJenisKelamin = rs.getInt(3);
						int kodeProdi = rs.getInt(4);
						String username = rs.getString(5);
						MahasiswaObject mahasiswa = new MahasiswaObject(	namaMahasiswa, nimMahasiswa, kodeJenisKelamin, kodeProdi, username);
						list.add(mahasiswa);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return list;
		}
		return list;
	}
}
%>

<%!
	class MahasiswaObject {
		String nim;
		String nama;
		int kode_jenis_kelamin;
		int kode_prodi;
		String username;
		
		MahasiswaObject(){
		}
		
		MahasiswaObject(String nama, String nim, int kode_jenis_kelamin, int kode_prodi, String username){
			this.nama = nama;
			this.nim = nim;
			this.kode_jenis_kelamin = kode_jenis_kelamin;
			this.kode_prodi = kode_prodi;
			this.username = username;
		}
		
		public String getNama(){
			return this.nama;
		}
		
		public String getNim(){
			return this.nim;
		}
		
		public int getKode_jenis_kelamin(){
			return this.kode_jenis_kelamin;
		}
		
		public int getKode_prodi(){
			return this.kode_prodi;
		}
	}
%>