package com.itu16.ticketing.service;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.lang.reflect.ParameterizedType;
import java.util.List;

public abstract class CRUDService<T, M> {

    protected final EntityManagerFactory emf = Persistence.createEntityManagerFactory("default");
    protected Class<T> entityClass;

    @SuppressWarnings("unchecked")
    public CRUDService() {
        this.entityClass = (Class<T>) ((ParameterizedType) getClass()
                .getGenericSuperclass())
                .getActualTypeArguments()[0];
    }

    public void create(T entity) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(entity);
        em.getTransaction().commit();
        em.close();
    }

    public T findById(M id) {
        EntityManager em = emf.createEntityManager();
        T entity = em.find(entityClass, id);
        em.close();
        return entity;
    }

    public List<T> findAll() {
        EntityManager em = emf.createEntityManager();
        TypedQuery<T> query = em.createQuery("SELECT e FROM " + entityClass.getSimpleName() + " e", entityClass);
        List<T> entities = query.getResultList();
        em.close();
        return entities;
    }

    public void update(T entity) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.merge(entity);
        em.getTransaction().commit();
        em.close();
    }

    public void delete(M id) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        T entity = em.find(entityClass, id);
        if (entity != null) {
            em.remove(entity);
        }
        em.getTransaction().commit();
        em.close();
    }

    public <R> R getSingleValue(String sql, Class<R> resultClass, Object... params) {
        EntityManager em = emf.createEntityManager();
        R result = null;
        try {
            var query = em.createNativeQuery(sql);
            for (int i = 0; i < params.length; i++) {
                query.setParameter(i + 1, params[i]); // JDBC uses 1-based index
            }
            Object singleResult = query.getSingleResult();
            if (singleResult != null) {
                result = resultClass.cast(singleResult);
            }
        } catch (jakarta.persistence.NoResultException e) {
            // Aucun résultat : on retourne null
            result = null;
        } finally {
            em.close();
        }
        return result;
    }
}
