package edu.psgv.sweng861.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import edu.psgv.sweng861.model.Song;
import edu.psgv.sweng861.service.SongService;


@Controller
public class SongController {
	
	private static final String KEY ="c366b0a51c4ef672b6490da5dc88a3c7";
	
	private static final String LINK ="http://ws.audioscrobbler.com";
	
	public static void main(String args[]) {
		
		new SongController().searchBySongName("");
	}
	
	@Autowired
	SongService songService;
	
	/**
	 * Search songs via Last FM API and return to front end.
	 * @param searchSong
	 * @return
	 */
	@PostMapping(path="/searchBySongName")
	public @ResponseBody List<Song> searchBySongName(
			@RequestParam(name = "searchSong") String searchSong) {
		
		//System.out.println("searchBySongName isput is: " + searchSong);		
		
		String search = searchSong;

		InputStream is = null;
		
		List<Song> songList = new LinkedList<Song>();
		
		try {
			
			search = URLEncoder.encode(search, "US-ASCII");
			
			String searchLink = LINK + "/2.0/?method=track.search&track=" + search + "&api_key=" + KEY + "&format=json";
			
			//System.out.println(searchLink);
			
			URL url = new URL(searchLink);
			
			is = url.openStream();
			
			try(InputStreamReader isr = new InputStreamReader(is)){
				
				JSONParser parser = new JSONParser();
				
				JSONObject json = (JSONObject) parser.parse(isr);
				
				parseJsonData(json, 0, songList);
				
//				System.out.println("SongList size is: " +  songList.size());
//				
//				System.out.println("SongList is: " +  songList.toString());
	
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}					
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return songList;
	}
	
	/**
	 * Loading all song in favorite List.
	 */
	@GetMapping(path="/loadAllFavorite")
	public @ResponseBody List<Song> loadAllFavorite() {
		
		return songService.loadAllFavorite();
	}

	/**
	 * Add a new song to favorite list.
	 */
	@PostMapping(path="/addFavorite", consumes="application/json")
	@ResponseStatus(value = HttpStatus.OK)
	public @ResponseBody Song addFavorite(@RequestBody Map<String, String> inputMap) {
		
		Song song = songService.addFavorite(inputMap);
		
		return song;
	}
	
	/**
	 * Remove a new song to favorite list.
	 */
	@DeleteMapping(path="/removeFavorite", consumes="application/json")
	@ResponseStatus(value = HttpStatus.OK)
	public @ResponseBody Song removeFavorite(	@RequestBody Map<String, String> inputMap) {
		
		Song song = songService.removeFavorite(inputMap);
		
		return song;
	}
	
	/**
	 * Parse json data retrieved from Last FM API.
	 * @param jsonObject
	 * @param tab
	 * @param songList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private List<Song> parseJsonData(Object jsonObject, int tab, List<Song> songList) {
		
		int tabCount = tab;
		
		String tabString = "";
		
		for(int i = 0; i < tabCount; i++) {
			
			tabString = tabString + "  ";
		}
		
		if(jsonObject instanceof Map) {		
		
			Set<Map.Entry<Object, Object>> entrySet = ((Map<Object, Object>) jsonObject).entrySet();
			
			Song song = new Song();
			
			for(Map.Entry<Object, Object> entry: entrySet) {
				
				if(entry.getValue() instanceof String) {
					
					System.out.println(tabString + entry.getKey() + ": " + entry.getValue());
					
					String key = (String) entry.getKey();
					
					String value = (String) entry.getValue();
					
					setSongValue(song, key, value);
					
				} else {
					
					System.out.println(tabString + entry.getKey());
					
					parseJsonData(entry.getValue(), tabCount + 1, songList);
				}
			}
			if(!song.isEmpty()) {
				
				//System.out.println(song.toString());
				
				songList.add(song);
			}			
		} else if (jsonObject instanceof List){
			
			List<Object> jsonList = (List<Object>) jsonObject;
			
			//System.out.println("a list");
			
			for(Object json: jsonList) {
					
				if(json instanceof String || json instanceof Long || json instanceof Double) {
					
					//System.out.println(tabString + json.toString());
					
				} else {
					
					parseJsonData(json, tabCount + 1, songList);
				}
			}
		}
		
		return songList;
	}


	/**
	 * Put returned value into a song Object.
	 * @param song
	 * @param key
	 * @param value
	 */
	private void setSongValue(Song song, String key, String value) {
		
		//System.out.println("key is " + key + ", value is " + value);
		
		if(key.equals("name")) {
			
			//System.out.println("setName");
			song.setName(value);
			
		} else if(key.equals("artist")) {
			
			//System.out.println("setArtist");
			song.setArtist(value);
			
		} else if(key.equals("url")) {
			
			//System.out.println("setUrl");
			song.setUrl(value);
		}
		
	} 
}
