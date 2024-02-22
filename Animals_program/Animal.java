import java.util.ArrayList;
import java.util.Date;
import java.util.List;

// Базовый класс для домашних животных
public class Animal {
    private String name;
    private String genus;
    private Date birthDate;
    private List<String> commands;

    public Animal(String name, String genus, Date birthDate) {
        this.name = name;
        this.genus = genus;
        this.birthDate = birthDate;
        this.commands = new ArrayList<>();
    }

    public String getName() {
        return name;
    }

    public String getGenus() {
        return genus;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public List<String> getCommands() {
        return commands;
    }

    public void teachNewCommand(String command) {
        commands.add(command);
    }
}