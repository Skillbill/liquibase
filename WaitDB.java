import java.sql.DriverManager;

public class WaitDB{
 
    
    public void connect() throws Exception {
        final String url = System.getenv("LIQUIBASE_URL");
        final String user = System.getenv("LIQUIBASE_USERNAME");
        final String password = System.getenv("LIQUIBASE_PASSWORD");
        boolean connected = false;
        while (!connected) {
            try {
                DriverManager.getConnection(url, user, password);
                System.out.println("Connected to the DB server successfully.");
                connected = true;
            } catch (Exception e) {
                System.out.println("Impossible to connect (" + e.getMessage() + "). Sleep...");
                e.printStackTrace();
                Thread.currentThread().sleep(2000);

            }
        }
    }
 
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws Exception  {
        WaitDB app = new WaitDB();
        app.connect();
    }
}