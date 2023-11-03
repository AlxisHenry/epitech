package Observer;

import java.util.List;
import java.util.ArrayList;

public class Order implements Observable {
	private String position;
	private String destination;
	private int timeBeforeArrival;
	private List<Observer> observers = new ArrayList<Observer>();
	
	public String getPosition() {
		return this.position;
	}
	
	public String getDestination () {
		return this.destination;
	}
	
	public int getTimeBeforeArrival() {
		return this.timeBeforeArrival;
	}
	
	public void setData(String position, String destination, int timeBeforeArrival) {
		this.position = position;
		this.destination = destination;
		this.timeBeforeArrival = timeBeforeArrival;
		this.notifyObservers();
	}

	public void addObserver(Observer observer) {
		this.observers.add(observer);
		
	}

	public boolean notifyObservers() {
		boolean success = true;
        for (Observer observer : observers) {
            if (observer != null) {
                observer.update(this);
            } else {
                success = false;
            }
        }
        return success;
	}
}
