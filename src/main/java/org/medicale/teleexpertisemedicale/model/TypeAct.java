package org.medicale.teleexpertisemedicale.model;

public enum TypeAct {
    RADIO(100),
    ECHO(200),
    LASER(300),
    ANALYSE_SANG(400);
    private final double price;
    TypeAct(double price) {
        this.price = price;
    }
    public double getPrice() {
        return price;
    }
}
