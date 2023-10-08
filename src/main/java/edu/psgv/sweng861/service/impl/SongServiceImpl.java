package edu.psgv.sweng861.service.impl;


import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.psgv.sweng861.model.Song;
import edu.psgv.sweng861.repository.SongRepository;
import edu.psgv.sweng861.service.SongService;


@Service
@Transactional
public class SongServiceImpl implements SongService {

	@Autowired
	SongRepository songRepository;

	@Override
	public List<Song> loadAllFavorite() {
		
		return songRepository.loadAllFavorite();
	}

	@Override
	public Song addFavorite(Map<String, String> inputMap) {
		
//		Song song = new Song(inputMap.get("name"), inputMap.get("artist"), inputMap.get("url"));
		
		Song song = new Song();
		
		song.setName(inputMap.get("name"));
		
		song.setArtist(inputMap.get("artist"));
		
		song.setUrl(inputMap.get("url"));
		
		songRepository.addFavorite(song);		
		
		return song;
	}

	@Override
	public Song removeFavorite(Map<String, String> inputMap) {

		Song song = new Song(inputMap.get("name"), inputMap.get("artist"), inputMap.get("url"), Long.valueOf(inputMap.get("id")));
		
		songRepository.removeFavorite(song);		
		
		return song;
	}

	
}
