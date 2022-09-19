import java.io.*;
import java.net.*;
import java.util.Date;

public class Client {
	public static void main(String[] args) {
		int		port = 10998;

		try (Socket sock = new Socket("127.0.0.1", port)) {
			System.out.println("Client is Connect on port " + port);

				InputStream input = sock.getInputStream();

				BufferedReader reader = new BufferedReader(new InputStreamReader(input));

				String time = reader.readLine();
				System.out.println(time);

				sock.close();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}
}
