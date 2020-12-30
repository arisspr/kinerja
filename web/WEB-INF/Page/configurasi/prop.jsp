<%@page import="sun.misc.BASE64Decoder"%>
<%@page import="sun.misc.BASE64Encoder"%>
<%
//    String host = "MTkyLjE2OC4wLjc=";//0.7
//    String host = "MTkyLjE2OC4xLjc=";//1.7
//    String port = "MjgxMA==";//2810
    String host = "MTAuMjU1LjIyMS4xNTA=";
//    String port = "MTk5MQ==";//1991 local
    String port = "MjU1Mg==";//2552 server
    String db = "YWN0aXZpdHk=";
    BASE64Decoder decoder = new BASE64Decoder();
    BASE64Encoder encoder = new BASE64Encoder();
    byte[] decodedHost = decoder.decodeBuffer(host);
    byte[] decodedPort = decoder.decodeBuffer(port);
    byte[] decodedDb = decoder.decodeBuffer(db);
//    String encodeHost = encoder.encodeBuffer("192.168.1.7".getBytes());
//    System.out.println("Jaringan Local : " + encodeHost);
//    host = "192.168.1.7";
    String url = "jdbc:postgresql://" + new String(decodedHost) + ":" + new String(decodedPort) + "/" + new String(decodedDb);
//    String url = "jdbc:postgresql://" + host + ":" + new String(decodedPort) + "/" + new String(decodedDb);

    String usr = "ZGlzbmFrZXI=";
//    String pwd = "ZGlzbmFrZXIzMjE=";//server
    String pwd = "aGVhdmVub3JoZWxs";//local
    byte[] decodedUsr = decoder.decodeBuffer(usr);
    byte[] decodedPwd = decoder.decodeBuffer(pwd);
    usr = new String(decodedUsr);
    pwd = new String(decodedPwd);
%>