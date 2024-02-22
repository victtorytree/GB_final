public class Main {
    public static void main(String[] args) {
        Reserve animalControl = new Reserve();
        try {
            animalControl.start();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}