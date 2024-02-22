public class AnimalCounter implements AutoCloseable {
    private int animals_amount;

    public AnimalCounter() {
        this.animals_amount = 0;
    }

    public void add() {
        animals_amount++;
    }
    public Integer getCount() {
        return animals_amount;
    }
    @Override
    public void close() throws Exception {
    }
}
