import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.*;
import java.nio.ByteBuffer;
import java.sql.Blob;
import java.util.ArrayList;
import java.util.List;

import javax.sound.sampled.*;

public class AudioStreamingServer {
    static AudioBroadcastingServer server;

    AudioInputStream audioInputStream;
    static AudioInputStream ais;
    static AudioFormat format;
    static boolean status = true;
    static int port = 50005;
    static int sampleRate = 44100;

    static DataLine.Info dataLineInfo;
    static SourceDataLine sourceDataLine;

    public static void main(String args[]) throws Exception
    {
        System.out.println("Server started at port:"+port);

        try {
            server = new AudioBroadcastingServer();
        } catch (IOException e) {
            e.printStackTrace();
        }

        DatagramSocket serverSocket = new DatagramSocket(port);

        /**
         * Formula for lag = (byte_size/sample_rate)*2
         * Byte size 9728 will produce ~ 0.45 seconds of lag. Voice slightly broken.
         * Byte size 1400 will produce ~ 0.06 seconds of lag. Voice extremely broken.
         * Byte size 4000 will produce ~ 0.18 seconds of lag. Voice slightly more broken then 9728.
         */

        byte[] receiveData = new byte[4096];

        format = new AudioFormat(sampleRate, 16, 2, true, false);
        dataLineInfo = new DataLine.Info(SourceDataLine.class, format);
        sourceDataLine = (SourceDataLine) AudioSystem.getLine(dataLineInfo);
        sourceDataLine.open(format);
        sourceDataLine.start();

        //FloatControl volumeControl = (FloatControl) sourceDataLine.getControl(FloatControl.Type.MASTER_GAIN);
        //volumeControl.setValue(1.00f);

        DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);

        ByteArrayInputStream baiss = new ByteArrayInputStream(receivePacket.getData());
        List<Byte> song = new ArrayList<>();

        while (status == true)
        {
            serverSocket.receive(receivePacket);

            for(int i = 0; i < receivePacket.getData().length; i++){
                String s = new String(receivePacket.getData());
                if(s.equals("STOP!")){
                    ais = new AudioInputStream(baiss, format, receivePacket.getLength());
                    play(receivePacket.getData());
                } else {
                    song.add(receivePacket.getData()[i]);
                }
            }
        }

        sourceDataLine.drain();
        sourceDataLine.close();
    }

    public static void toSpeaker(byte soundbytes[]) {
        try {
            System.out.println("Broadcasting bytes to socket.");
            sourceDataLine.write(soundbytes, 0, soundbytes.length);
            server.writeData(soundbytes);
        } catch (Exception e) {
            System.out.println("Socket not working.");
            e.printStackTrace();
        }
    }

    private static void play(byte[] data){
        AudioFormat format = new AudioFormat(AudioFormat.Encoding.PCM_SIGNED, 44100, 16, 2, (16 / 8) * 2, 44100, false);
        TargetDataLine line;

        DataLine.Info info = new DataLine.Info(TargetDataLine.class, format);
        if (!AudioSystem.isLineSupported(info)) {
            System.out.println("Line matching " + info + " not supported.");
            return;
        }

        try {
            line = (TargetDataLine) AudioSystem.getLine(info);

            //TOTALLY missed this.
//            int buffsize = line.getBufferSize() / 5;
//            buffsize += 512;
            int buffsize = 4096;

            line.open(format);

            line.start();

            int numBytesRead;

            InetAddress addr = InetAddress.getByName("127.0.0.1");
            try(DatagramSocket socket = new DatagramSocket()) {
                while (true) {
                    for(byte b : data) System.out.print(b + " ");

                    // Read the next chunk of data from the TargetDataLine.
//                  numBytesRead = line.read(data, 0, data.length);

                    for(int i = 0; i < 64; i++) {
                        byte b = data[i];
                        System.out.print(b + " ");
                    }
                    System.out.println();

                    // Save this chunk of data.
//                    DatagramPacket dgp = new DatagramPacket(data, data.length, addr, 50005);
                    DatagramPacket dgp = new DatagramPacket(data,  data.length, addr, 50005);

                    toSpeaker(dgp.getData());
                }
            }

        } catch (LineUnavailableException e) {
            e.printStackTrace();
        } catch (UnknownHostException e) {
            // TODO: handle exception
        } catch (SocketException e) {
            // TODO: handle exception
        } catch (IOException e2) {
            // TODO: handle exception
        }
    }
}
