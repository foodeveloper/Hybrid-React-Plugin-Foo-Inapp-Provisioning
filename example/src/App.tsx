import * as React from 'react';

import { StyleSheet, View, Text, Button } from 'react-native';
import { setHostName , addCardForUserId , addCardForPanId , type CardUserIdDetails, type CardPanIdDetails  } from 'fooapplewalletplugin';

export default function App() {
  
const testDataUserId:CardUserIdDetails = {
    userId: 'U12345',
    deviceId: 'D67890',
    cardId: 'C11223',
    cardHolderName: 'Alice Roberts',
    cardPanSuffix: '4321',
    sessionId: 'S45678',
    localizedDescription: 'Sample card for testing purposes'

}
const testDataPanId:CardPanIdDetails = {
     userId: 'U12345',
    deviceId: 'D67890',
    cardId: 'C11223',
    cardHolderName: 'Alice Roberts',
    cardPanSuffix: '1234',
    localizedDescription: 'Sample card for testing purposes',
    pan: '5457920006321234',
    expiryDate: '12/25'

}

  
  React.useEffect(() => {
  setHostName("https://api.sandbox.checkout.com" , "/tokens/card").then(res=>console.log("from",res));
    
  }, []);

  return (
    <View style={styles.container}>
      <Text>Test App</Text>
      
      <Button title="User ID" onPress={()=>{addCardForUserId(testDataUserId).then(res => {
      console.log("Success added:", res);
    })
    .catch(error => {
      console.error("Error adding:", error);
    }); }} />
       <Button title="Pan ID" onPress={()=>{addCardForPanId(testDataPanId).then(res => {
      console.log("Success added:", res);
    })
    .catch(error => {
      console.error("Error adding:", error);
    }); }} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});