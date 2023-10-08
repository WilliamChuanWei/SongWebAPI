package edu.psgv.sweng861.service;

import java.util.List;
import java.util.Map;

import edu.psgv.sweng861.model.Song;

public interface SongService {

	List<Song> loadAllFavorite();

	Song addFavorite(Map<String, String> inputMap);

	Song removeFavorite(Map<String, String> inputMap);
}
