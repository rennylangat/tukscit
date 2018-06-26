<uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

try {
                HttpHelper http = new HttpHelper("member/signin/" + pin, null);
                http.processVals(new IExecute() {
                    @Override
                    public void run(String val) {
                        try {
                            JSONObject obj = new JSONObject(val);
                            if (((Integer)obj.get("status")) == -8){
                                String key = (String)obj.get("key");
                                String uname = (String)obj.get("name");

                                Intent rooms = new Intent(that, RoomsActivity.class);
                                rooms.putExtra(SESSION, key);
                                rooms.putExtra(NAME, uname);
                                startActivity(rooms);
                            } else {
                                msg.show();
                            }
                        } catch (JSONException e) {
                            Log.e("HomeActivity", e.getMessage(), e);
                        }
                    }
                });
            } catch (Exception ex){
                Log.e("HomeActivity", ex.getMessage(), ex);
            }
