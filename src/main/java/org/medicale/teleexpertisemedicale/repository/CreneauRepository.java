package org.medicale.teleexpertisemedicale.repository;

import javax.persistence.EntityManagerFactory;

public class CreneauRepository {
   private final EntityManagerFactory emf;
   public CreneauRepository(EntityManagerFactory emf) {
       this.emf = emf;
   }
}
