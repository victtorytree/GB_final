public class AnimalCounter implements AutoCloseable {
    private int animals_amount;

    public void add() {
        animals_amount++;
    }
    public Integer getCount() {
        return animals_amount;
    }
    @Override
    public void close() throws Exception {
        throw new UnsupportedOperationException("error: unable to add animal");
    }
}
