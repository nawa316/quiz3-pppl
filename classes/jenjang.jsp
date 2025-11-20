<%@ page import="java.sql.*, java.util.*" %>
<%!
class Jenjang {
    
    Connection con;
    
    Jenjang(Connection con){
        this.con = con;
    }

    public JenjangObject get(int kode) {
        try {
            if (this.con == null) {
                return null;
            }
            String sql = "SELECT * FROM jenjang WHERE kode = ?";
            // Menggunakan try-with-resources (PS & RS tertutup otomatis, KONEKSI TETAP HIDUP)
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, kode);
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        // Menggunakan nama kolom
                        int kodeJenjang = rs.getInt("kode");
                        String namaJenjang = rs.getString("nama");
                        
                        return new JenjangObject(kodeJenjang, namaJenjang);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;       
        }
        return null;
    }

    public boolean insert(JenjangObject jenjang){
        try {
            if (this.con == null) {
                return false;
            }
            String sql = "INSERT INTO jenjang (nama) VALUES (?) ";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, jenjang.getNama());
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

    public List<JenjangObject> list(){
        List<JenjangObject> list = new ArrayList<>();
        try {
            if (this.con == null) {
                return list;
            }
            String sql = "SELECT * FROM jenjang";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        int kodeJenjang = rs.getInt("kode");
                        String namaJenjang = rs.getString("nama");
                        
                        list.add(new JenjangObject(kodeJenjang, namaJenjang));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return list;       
        }
        return list;
    }

    public boolean update(JenjangObject jenjang){
        try {
            if (this.con == null) {
                return false;
            }
            String sql = "UPDATE jenjang SET nama = ? WHERE kode = ? ";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, jenjang.getNama());
                ps.setInt(2, jenjang.getKode());
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

    public boolean delete(int kode){
        try {
            if (this.con == null) {
                return false;
            }
            String sql = "DELETE FROM jenjang WHERE kode = ? ";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, kode);
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
}
%>

<%! 
class JenjangObject {
    
    int kode;
    String nama;

    // Constructor Kosong
    public JenjangObject() {}

    // Constructor dengan Parameter (Baru)
    public JenjangObject(int kode, String nama) {
        this.kode = kode;
        this.nama = nama;
    }

    public int getKode() {
        return kode;
    }

    public void setKode(int kode) {
        this.kode = kode;
    }

    public String getNama() {
        return nama;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }
}
%>