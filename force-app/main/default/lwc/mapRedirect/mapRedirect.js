import { LightningElement } from 'lwc';

export default class MapRedirect extends LightningElement {
    // Ending location latitude and longitude
    endLatitude = 26.839754; // Replace with your ending latitude
    endLongitude = 75.801664; // Replace with your ending longitude
    selectedMarkerValue = 'SF1';
    mapMarkers = [
        {
            location: {
                Latitude: '26.839754',
                Longitude: '75.801664'
            },
            title: 'Patricagate', // Replace with your title
        }
    ];
    //kdjfldjkfdsfjsk
    handleDirectionClick() {
        // const mapsUrl = `https://www.google.com/maps/dir/?api=1&origin=${this.startLatitude},${this.startLongitude}&destination=${this.endLatitude},${this.endLongitude}`;
        const mapsUrl = `https://www.google.com/maps/dir/?api=1&origin=My+Location&destination=${this.endLatitude},${this.endLongitude}`;
        window.open(mapsUrl, '_blank');
    }
    handleMarkerSelect(event) {
        let latitude = event.target.mapMarkers[0].location.Latitude;
        let longitude = event.target.mapMarkers[0].location.Longitude;
        const mapsUrl = 'https://www.google.com/maps/dir/?api=1&origin=My+Location&destination='+latitude+','+longitude;
        window.open(mapsUrl, '_blank');
    }
}