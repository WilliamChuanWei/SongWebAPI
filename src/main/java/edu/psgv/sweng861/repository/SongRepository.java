package edu.psgv.sweng861.repository;

import java.util.List;

import edu.psgv.sweng861.model.Song;


public interface SongRepository {

	List<Song> loadAllFavorite();

	void addFavorite(Song song);

	void removeFavorite(Song song);

}
