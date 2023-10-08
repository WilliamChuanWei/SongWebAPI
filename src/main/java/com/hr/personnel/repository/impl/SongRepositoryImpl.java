package com.hr.personnel.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hr.personnel.model.Song;
import com.hr.personnel.repository.SongRepository;

@Repository
public class SongRepositoryImpl implements SongRepository {
	
	@Autowired
	EntityManager entityManager;
	
	@Override
	public List<Song> loadAllFavorite() {

		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		
		CriteriaQuery<Song> criteriaQuery = criteriaBuilder.createQuery(Song.class);
		
		Root<Song> root = criteriaQuery.from(Song.class);
		
		CriteriaQuery<Song> allSongDetail = criteriaQuery.select(root);
		
		List<Song> songList = entityManager.createQuery(allSongDetail).getResultList();

		return songList;
	}


	@Override
	public void addFavorite(Song song) {

		entityManager.persist(song);
	}


	@Override
	public void removeFavorite(Song song) {
		
		Long id = song.getId();
		try {
			int result = entityManager.createQuery("delete from song where id = :id").setParameter("id", id).executeUpdate();
			
			System.out.println(result);
			
		}catch(Exception e) {
			
			e.printStackTrace();
		}
	}
}
