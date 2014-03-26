<div class="form-group">
<label for="tv[[+tv.id]]">
[[+tv.caption]] ({{[[+tv.fieldname]]_is_searching}} {{[[+tv.fieldname]]_query}})
</label>
                <typeahead class="typeahead" items="music" term="term" search="searchMusic(term)" select="selectMusic(item)">
                    <div class="menu" ng-cloak>
                        <h3 >Albums</h3>
                        <ul>
                            <li typeahead-item="album" ng-repeat="album in albums" class="results">
                                <img ng-src="{{imageSource(album)}}"><p class="name">{{album.name}}</p><p class="artist">{{album.artist}}</p>
                            </li>
                        </ul>
                    </div>
                </typeahead>

</div>