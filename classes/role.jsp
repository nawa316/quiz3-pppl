<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%!
class Role {
    
    Connection con;
    
    Role(Connection con){
        this.con = con;
    }

    public RoleObject get(int kode) {
        try {
            if (this.con == null) {
                return null;
            }
            String sql = "SELECT * FROM role WHERE kode = ?";
            // Menggunakan try-with-resources untuk PreparedStatement & ResultSet
            // Koneksi (con) TIDAK DITUTUP
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, kode);
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        // Menggunakan nama kolom
                        int kodeRole = rs.getInt("kode");
                        String namaRole = rs.getString("nama");
                        
                        // PERBAIKAN: Langsung return objectnya
                        return new RoleObject(kodeRole, namaRole);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;       
        }
        return null;
    } 
    
    public boolean update(RoleObject role){
        try {
            if (this.con == null) {
                return false;
            }
            String sql = "UPDATE role SET nama = ? WHERE kode = ? ";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, role.nama);
                ps.setInt(2, role.kode);
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

    public boolean insert(RoleObject role){
        try {
            if (this.con == null) {
                return false;
            }
            String sql = "INSERT INTO role (nama) VALUES ( ? ) ";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, role.nama);
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
            String sql = "DELETE FROM role WHERE kode = ? ";
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

    public List<RoleObject> list(){
        List<RoleObject> roles = new ArrayList<>();
        try {
            if (this.con == null) {
                return roles;
            }
            String sql = "SELECT * FROM role ";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        int kode = rs.getInt("kode");
                        String nama = rs.getString("nama");
                        RoleObject role = new RoleObject(kode, nama);
                        roles.add(role);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return roles;       
        }
        return roles;
    }
}
%>

<%! 
class RoleObject {
    int kode;
    String nama;
    RoleObject(){}

    RoleObject(int kode, String nama){
        this.kode = kode;
        this.nama = nama;
    }
}
%>