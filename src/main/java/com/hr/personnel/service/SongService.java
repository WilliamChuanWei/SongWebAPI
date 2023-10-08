package com.hr.personnel.service;

import java.util.List;
import java.util.Map;

import com.hr.personnel.model.Song;

public interface SongService {

	List<Song> loadAllFavorite();

	Song addFavorite(Map<String, String> inputMap);

	Song removeFavorite(Map<String, String> inputMap);
}
