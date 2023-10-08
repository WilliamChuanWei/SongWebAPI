package com.hr.personnel.repository;

import java.util.List;

import com.hr.personnel.model.Song;

public interface SongRepository {

	List<Song> loadAllFavorite();

	void addFavorite(Song song);

	void removeFavorite(Song song);

}
