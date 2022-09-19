import java.io.*;
import java.net.*;
import java.util.Date;

public class Server {
	public static void main(String[] args) {
		int		port = 10998;

		try (ServerSocket ss = new ServerSocket(port)) {
			System.out.println("Server is Listening on port " + port);

			while(true) {
				Socket sock = ss.accept();
				System.out.println("New Client Socket OK");

				OutputStream output = sock.getOutputStream();

				PrintWriter writer = new PrintWriter(output, true);
				writer.println(new Date().toString());
				sock.close();
			}
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}
}
