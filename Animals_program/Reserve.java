import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.*;

// Класс для управления реестром домашних животных
public class Reserve {
    // Список животных в реестре
    private List<Animal> animals;

    // Счетчик животных
    private int animalCounter;

    // Формат даты
    private static final String DATE_FORMAT = "yyyy-MM-dd";

    // Конструктор класса
    public Reserve() {
        this.animals = new ArrayList<>();
        this.animalCounter = animals.size();
    }

    // Метод для добавления нового животного в реестр
    

    public void addAnimal(Animal animal) {
        animals.add(animal);
        animalCounter++;
    }

    // Метод для вывода списка команд для заданного животного
    public void listCommands(Animal animal) {
        System.out.println("List of commands for " + animal.getName() + ":");
        for (String command : animal.getCommands()) {
            System.out.println(command);
        }
    }

    // Метод для обучения новой команды для заданного животного
    public void teachNewCommand(Animal animal, String newCommand) {
        animal.teachNewCommand(newCommand);
        System.out.println("Command '" + newCommand + "' studied by " + animal.getName());
    }

    // Метод для вывода списка животных, отсортированных по дате рождения
    public void listAnimalsByBirthDate() {
        System.out.println("List of animals, by birthdate:");
        animals.sort(Comparator.comparing(Animal::getBirthDate));
        for (Animal animal : animals) {
            System.out.println("Nickname: " + animal.getName() + ", Genus: " + animal.getGenus() + ", Date of Birth: "
                    + new SimpleDateFormat(DATE_FORMAT).format(animal.getBirthDate()));
        }
    }

    // Метод для вывода общего количества животных
    public void showTotalAnimalCount() {
        System.out.println("Total animals quantity: " + animalCounter);
    }

    // Метод для вывода меню и обработки выбора пользователя
    public void printMenu() {
        System.out.println("1 -> Add new animal");
        System.out.println("2 -> Animal`s list of commands");
        System.out.println("3 -> Teach new command");
        System.out.println("4 -> List of animals by birthdate");
        System.out.println("5 -> Total quantity of animals");
        System.out.println("0 -> Exit");
        System.out.print("Your choice: ");
    }

    // Метод для парсинга даты из строки
    private Date parseDate(String input) {
        try {
            return new SimpleDateFormat(DATE_FORMAT).parse(input);
        } catch (ParseException e) {
            System.out.println("Incorrect data format. Please enter birthdate YYYY-MM-DD");
            return new Date();
        }
    }

    // Метод для создания животного на основе ввода пользователя
    private Animal createAnimalFromUserInput() throws Exception {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter nickname: ");
        String name = scanner.nextLine();
        System.out.print("Enter type (Cat / Dog / Hamster / Horse / Camel / Donkey ) ");
        String type = scanner.nextLine();
        System.out.print("Enter birthdate (YYYY-MM-DD): ");
        Date birthDate = parseDate(scanner.nextLine());
        try(AnimalCounter counter = new AnimalCounter()){
            counter.add();
        }
        switch (type.toLowerCase()) {
            case "dog":
                return new Dog(name, birthDate);
            case "cat":
                return new Cat(name, birthDate);
            case "hamster":
                return new Hamster(name, birthDate);
            case "horse":
                return new Horse(name, birthDate);
            case "camel":
                return new Camel(name, birthDate);
            case "donkey":
                return new Hamster(name, birthDate);
            default:
                System.out.println("Incorrect animal genus");
                return null;
        }
    }

    // Метод для запуска программы
    public void start() throws Exception {
        Scanner scanner = new Scanner(System.in);
        int choice;

        do {
            printMenu();
            choice = scanner.nextInt();
            scanner.nextLine(); // Считываем символ новой строки

            switch (choice) {
                case 1:
                    Animal newAnimal = createAnimalFromUserInput();
                    if (newAnimal != null) {
                        addAnimal(newAnimal);
                        System.out.println("Animal successfully added");
                    }
                    break;
                case 2:
                    System.out.print("Enter nickname: ");
                    String animalName = scanner.nextLine();
                    Animal specifiedAnimal = findAnimalByName(animalName);
                    if (specifiedAnimal != null) {
                        listCommands(specifiedAnimal);
                    } else {
                        System.out.println("Animal not found");
                    }
                    break;
                case 3:
                    System.out.print("Enter nickname: ");
                    String animalNameToTeach = scanner.nextLine();
                    Animal animalToTeach = findAnimalByName(animalNameToTeach);
                    if (animalToTeach != null) {
                        System.out.print("Enter command which you want to teach: ");
                        String newCommand = scanner.nextLine();
                        teachNewCommand(animalToTeach, newCommand);
                    } else {
                        System.out.println("Animal not found");
                    }
                    break;
                case 4:
                    listAnimalsByBirthDate();
                    break;
                case 5:
                    showTotalAnimalCount();
                    break;
                case 0:
                    System.out.println("Until next time using");
                    break;
                default:
                    System.out.println("Incorrect choice. PLease repeat");
            }
        } while (choice != 0);
    }

    // Метод для поиска животного по имени
    private Animal findAnimalByName(String name) {
        for (Animal animal : animals) {
            if (animal.getName().equalsIgnoreCase(name)) {
                return animal;
            }
        }
        return null;
    }
}
