package edu.psgv.sweng861.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity(name = "song")
@Table(name = "song")
@Component("song")
public class Song {

	public Song(String name, String artist, String url, Long id) {
		super();
		this.name = name;
		this.artist = artist;
		this.url = url;
		this.id = id;
	}
	
	private String name;

	private String artist;
	
	
	private String url;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getArtist() {
		return artist;
	}

	public void setArtist(String artist) {
		this.artist = artist;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Song() {
		super();
	}
	
	public boolean isEmpty() {
		
		if(this.name == null || this.artist == null || this.url == null) {
			
			return true;
			
		} else {
			
			return false;
		}
	}
	
	public static void main(String args[]) {
		
		Song s = new Song();
		
		System.out.println(s.isEmpty());
	}

	@Override
	public String toString() {
		return "Song [name=" + name + ", artist=" + artist + ", url=" + url + "]";
	}
}
