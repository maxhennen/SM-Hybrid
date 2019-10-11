import javax.sound.sampled.AudioFormat;
import java.io.*;
import java.net.*;

public class AudioBroadcastingServer {
    private OutgoingSoundListener osl = new OutgoingSoundListener();
    boolean outVoice = true;
    DatagramPacket packet;
    AudioFormat format = getAudioFormat();

    private DatagramSocket serverSocket;
    Socket server;

    private AudioFormat getAudioFormat() {
        float sampleRate = 44100;
        int sampleSizeBits = 16;
        int channels = 2;
        boolean signed = true;
        boolean bigEndian = false;

        return new AudioFormat(sampleRate, sampleSizeBits, channels, signed, bigEndian);
    }

    public AudioBroadcastingServer() throws IOException {
        try {
            System.out.println("Creating Socket...");
            serverSocket = new DatagramSocket(3000);
            osl.runSender();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void writeData(byte[] tmpBuff){
        try {
            osl.writeData(tmpBuff);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void closeData(){
        try {
            osl.closeData();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    class OutgoingSoundListener {
        DataOutputStream out;

        public void runSender() {
            try {
                //out = new DataOutputStream(server.getOutputStream());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        public void writeData(byte[] tmpBuff) throws IOException {
            int count = tmpBuff.length;
            if (count > 0) {
                System.out.println("Writing buffer to server.");
                InetAddress addr = InetAddress.getByName("127.0.0.1");
                packet = new DatagramPacket(tmpBuff, 0, tmpBuff.length, addr, 3000);
                serverSocket.send(packet);
//                out.write(tmpBuff, 0, count);
                System.out.println("Bytes written");
            }
        }

        public void closeData() throws IOException {
            out.close();
        }

    }

    public static void main(String args[]) throws IOException {
        new AudioBroadcastingServer();

    }
}