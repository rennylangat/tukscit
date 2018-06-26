package ke.co.lefins.nightplus;

import android.os.AsyncTask;
import android.util.Log;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.HttpURLConnection;
import java.net.URL;

import ke.co.lefins.nightplus.exceptions.InvalidParameterException;

/**
 * Created by otkoth on 3/16/17.
 *
 * Member
 /client/{id} (string)
 /aclient
 private int id;

 private String name;

 private String address;

 private String mid;

 room (another)
 /rooms
 private int id;

 private String name;

 private double day;

 private double night;

 private String client;

 private int imid;
 /topay/{client}/{room}/{period}/{bfast}/{mpesa}/{days} (double)
 /book/{client}/{room}/{period}/{bfast}/{mpesa}/{days}/{date} (boolean)
 /daysavailable/{room}/{period}/{date} (int)

 */

public class HttpHelper extends AsyncTask<String, Void, String> {

    // 10.0.2.2
    // 192.168.8.101
    private static String BASE = "http://192.168.8.100:8080/hotel/api/";

    private IExecute exec;

    private HttpURLConnection con;

    private String data;

    public HttpHelper(String uri, String key)
            throws IOException, InvalidParameterException {
        if (uri == null || uri.trim().equals("")){
            throw new InvalidParameterException("address is null!");
        }

        URL url = new URL(BASE + uri);
        this.con = (HttpURLConnection)url.openConnection();

        if (key != null && !key.trim().equals("")){
            this.con.setRequestProperty("AuthorizationKey", key);
        }

        this.data = null;
    }

    public HttpHelper(String uri, String key, String data)
            throws IOException, InvalidParameterException {
        this(uri, key);

        this.con.setDoOutput(true);
        this.con.setRequestMethod("POST");
        this.con.setRequestProperty("Content-Type", "application/json");
        this.con.setRequestProperty("Accept", "application/json");

        this.data = data;
    }

    private String read(){

        if (this.data != null){
            try {
                Writer writer = new BufferedWriter(new OutputStreamWriter(this.con.getOutputStream(), "UTF-8"));
                writer.write(data);
                writer.close();
            } catch (Exception e){
                Log.e("HttpHelper", e.getMessage(), e);
                return null;
            }
        }

        StringBuilder sb = new StringBuilder();

        try {
            InputStream content = new BufferedInputStream(this.con.getInputStream());
            BufferedReader reader = new BufferedReader(new InputStreamReader(content));
            String line = null;
            while ((line = reader.readLine()) != null){
                sb.append(line);
            }
        } catch (IOException e) {
            Log.e("HttpHelper", e.getMessage(), e);
        }finally {
            con.disconnect();
        }

        return sb.toString();
    }

    @Override
    protected String doInBackground(String... urls) {
        return this.read();
    }

    @Override
    protected void onPostExecute(String s) {
        this.exec.run(s);
    }

    public void processVals(IExecute execute){
        this.exec = execute;
        this.execute();
    }
}
