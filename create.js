import React, { Component } from "react";
import Clock from "../components/Clock";
import Footer from '../components/footer';
import { createGlobalStyle } from 'styled-components';
import getWeb3 from "../../getWeb3";
import CreateEvent from "../../contracts/CreatEvent.json";
// import Storage from "../../contracts/Storage.json";





const GlobalStyles = createGlobalStyle;



export default class Createpage extends Component {
  state = {
    EventName: null,
    date: null,
    EventDescription: null,
    price: null,
    eventCapacity: null,

    value: null,
    web3: null,
    accounts: null,
    contract: null,
};



  componentDidMount = async () => {
    
    try {
      // Get network provider and web3 instance.
      const web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      const accounts = await web3.eth.getAccounts();

      // Get the contract instance.
    //   const networkId = await web3.eth.net.getId();
    //   const deployedNetwork = Storage.networks[networkId];
      const instance = new web3.eth.Contract(
        CreateEvent, //API json file
        "0x9A9Af2B951841fFCFe7ff67255a4e7C707A6B63d", //contract address
        
      );

      // Set web3, accounts, and contract to the state, and then proceed with an
      // example of interacting with the contract's methods.
      this.setState({ web3, accounts, contract: instance }, this.runExample);
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
      
    }
  };


Send = async(event) =>{
event.preventDefault();
const {accounts, contract} = this.state;
if(contract === undefined) {return}
console.log(this.state.EventName,this.state.date, this.state.eventCapacity, this.state.price, this.state.EventDescription, )
await contract.methods.createEvent(this.state.EventName, this.state.date, "930", this.state.price, this.state.eventCapacity, this.state.EventDescription).send({from: accounts[0]});
}

Get =async(event) => {
event.preventDefault();
const {accounts, contract} = this.state;
const responce = await contract.methods.getAllEvents().call();
this.setState({value: responce});
console.log(responce)
}



constructor() {
    super();
    this.onChange = this.onChange.bind(this);
    this.state = {
      files: [],
    };
  }

  onChange(e) {
    var files = e.target.files;
    console.log(files);
    var filesArr = Array.prototype.slice.call(files);
    console.log(filesArr);
    document.getElementById("file_name").style.display = "none";
    this.setState({ files: [...this.state.files, ...filesArr] });
  }

render() {
    return (
      <div>
{/* <button onClick={this.Send}>Send</button> */}
                <button onClick={this.Get}>Get Event</button>
        <section className='jumbotron breadcumb no-bg'>
          <div className='mainbreadcumb'>
            <div className='container'>
              <div className='row m-10-hor'>
                <div className='col-12'>
                  <h1 className='text-center'>إضافة فعالية</h1>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section className='container'>

        <div className="row">
          <div className="col-lg-7 offset-lg-1 mb-5">
              <form id="form-create-item" className="form-border" action="#">
                  <div className="field-set">
                      <h5>الصورة</h5>

                      <div className="d-create-file">
                          <p id="file_name">PNG, JPG, GIF, WEBP or MP4. Max 200mb.</p>
                          {this.state.files.map(x => 
                          <p key="{index}">PNG, JPG, GIF, WEBP or MP4. Max 200mb.{x.name}</p>
                          )}
                          <div className='browse'>
                            <input type="button" id="get_file" className="btn-main" value="استعراض"/>
                            <input id='upload_file' type="file" multiple onChange={this.onChange} />
                          </div>
                          
                      </div>

                      <div className="spacer-single"></div>

                      <h5>اسم الفعالية</h5>
                      <input type="text" name="item_title" id="item_title" className="form-control"  onChange={e => this.setState({EventName: e.target.value})} placeholder="أمسيةالأمير بدر عبدالمحسن الشعرية" />

                      <div className="spacer-10"></div>

                      <h5>الوصف</h5>
                      <textarea data-autoresize name="item_desc" id="item_desc" className="form-control" onChange={e => this.setState({EventDescription: e.target.value})} placeholder=" ... تهتم الفعالية في "></textarea>

                      <div className="spacer-10"></div>

                      <h5>سعر التذكرة</h5>
                      <input type="text" name="item_price" id="item_price" className="form-control" onChange={e => this.setState({price: e.target.value})} placeholder="أدخل سعر عنصر واحد (ETH)" />

                      <div className="spacer-10"></div>

                      <h5>الوقت</h5>
                      <input type="time" name="item_royalties" id="item_royalties" className="form-control" placeholder=" 00:00 م" />
                      <h5>التاريخ</h5>
                      <input type="number" name="item_royalties" id="item_royalties" className="form-control" onChange={e => this.setState({date: e.target.value})} placeholder=" DD/MM/YYYY" />
                      <h5>عدد التذاكر</h5>
                      <input type="number" name="item_royalties" id="item_royalties" className="form-control" onChange={e => this.setState({eventCapacity: e.target.value})} placeholder=" 0"  min="1" />


                      <div className="spacer-10"></div>

                      <input type="button" id="submit" onClick={this.Send} className="btn-main" value="انشاء الفعالية"/>
                  </div>
              </form>
          </div>
      </div>

      </section>

        <Footer />
      </div>
   );
  }
}
