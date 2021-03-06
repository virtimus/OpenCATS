<?php /* $Id: Show.tpl 3582 2007-11-12 22:58:48Z brian $ */
include_once('./vendor/autoload.php');
use OpenCATS\UI\QuickActionMenu;
?>
<?php TemplateUtility::printHeader(__('Company').' - '.$this->data['name'], array( 'js/sorttable.js', 'js/attachment.js')); ?>
<?php TemplateUtility::printHeaderBlock(); ?>
<?php TemplateUtility::printTabs($this->active); 


function tplAddContact($thisTpl){
?>
            <?php if ($thisTpl->getUserAccessLevel('contacts.add') >= ACCESS_LEVEL_EDIT): ?>
                <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=contacts&amp;a=add&amp;selected_company_id=<?php echo($thisTpl->companyID); ?>" title="<?php echo __("Add Contact");?>">
                    <img src="images/actions/add_contact.gif" width="16" height="16" class="absmiddle" alt="<?php echo __("add contact");?>" border="0" title="Add Contact"/>&nbsp;<?php echo __("Add Contact");?>
                </a>
            <?php endif; ?>
            <?php if (count($thisTpl->contactsRSWC) != count($thisTpl->contactsRS)) : ?>
                &nbsp;
                <a href="javascript:void(0)" id="linkShowAll" onclick="javascript:for (i = 0; i< <?php echo(count($thisTpl->contactsRSWC)); ?>; i++) document.getElementById('ContactsDefault'+i).style.display='none'; for (i = 0; i< <?php echo(count($thisTpl->contactsRS)); ?>; i++) document.getElementById('ContactsFull'+i).style.display=''; document.getElementById('linkShowAll').style.display='none'; document.getElementById('linkHideSome').style.display='';">
                    <img src="images/actions/add_contact.gif" width="16" height="16" class="absmiddle" alt="<?php echo __("add contact");?>" border="0" title="<?php echo __("Show All");?>"/>
                    &nbsp;<?php echo __("Show contacts who have left");?> (<?php echo(count($thisTpl->contactsRS) - count($thisTpl->contactsRSWC)); ?>)
                </a>
                <a href="javascript:void(0)" id="linkHideSome" style="display:none;" onclick="javascript:for (i = 0; i< <?php echo(count($thisTpl->contactsRSWC)); ?>; i++) document.getElementById('ContactsDefault'+i).style.display=''; for (i = 0; i< <?php echo(count($thisTpl->contactsRS)); ?>; i++) document.getElementById('ContactsFull'+i).style.display='none'; document.getElementById('linkShowAll').style.display=''; document.getElementById('linkHideSome').style.display='none';">
                    <img src="images/actions/add_contact.gif" width="16" height="16" class="absmiddle" alt="add contact" border="0" title="Hide Some"/>
                    &nbsp;<?php echo __("Hide contacts who have left");?> (<?php echo(count($thisTpl->contactsRS) - count($thisTpl->contactsRSWC)); ?>)
                </a>
            <?php endif; ?>

<?php
}

function tplAddJobOrder($thisTpl){
?>
            <?php if ($thisTpl->getUserAccessLevel('joborders.add') >= ACCESS_LEVEL_EDIT): ?>
                <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=joborders&amp;a=add&amp;selected_company_id=<?php echo($thisTpl->companyID); ?>" title="<?php echo __("Add Job Order");?>">
                    <img src="images/actions/job_order.gif" width="16" height="16" class="absmiddle" alt="<?php echo __("New Job Order");?>" border="0" />&nbsp;<?php echo __("Add Job Order");?>
                </a>
            <?php endif; ?>
<?php
}

function tplAddAttachment($thisTpl){
?>
                                    <?php if ($thisTpl->getUserAccessLevel('companies.createAttachment') >= ACCESS_LEVEL_EDIT): ?>
                                            <?php if (isset($thisTpl->attachmentLinkHTML)): ?>
                                                <?php echo($thisTpl->attachmentLinkHTML); ?>
                                            <?php else: ?>
                                                <a href="#" onclick="showPopWin('<?php echo(CATSUtility::getIndexName()); ?>?m=companies&amp;a=createAttachment&amp;companyID=<?php echo($thisTpl->companyID); ?>', 400, 125, null); return false;">
                                            
                                            <img src="images/paperclip_add.gif" width="16" height="16" border="0" alt="add attachment" class="absmiddle" />&nbsp;<?php echo __("Add Attachment");?>
                                            </a>
                                      		<?php endif; ?>
                                    <?php endif; ?>
<?php
}

function tplActions($thisTpl,$top=false){
?>
            <?php if ($thisTpl->getUserAccessLevel('companies.edit') >= ACCESS_LEVEL_EDIT): ?>
                <a id="edit_link" href="<?php echo(CATSUtility::getIndexName()); ?>?m=companies&amp;a=edit&amp;companyID=<?php echo($thisTpl->companyID); ?>">
                    <img src="images/actions/edit.gif" width="16" height="16" class="absmiddle" alt="<?php echo __("edit");?>" border="0" />&nbsp;<?php echo __("Edit");?>
                </a>
                &nbsp;&nbsp;&nbsp;&nbsp;
            <?php endif; ?>
            <?php if ($thisTpl->getUserAccessLevel('companies.delete') >= ACCESS_LEVEL_DELETE && $thisTpl->data['defaultCompany'] != 1): ?>
                <a id="delete_link" href="<?php echo(CATSUtility::getIndexName()); ?>?m=companies&amp;a=delete&amp;companyID=<?php echo($thisTpl->companyID); ?>" onclick="javascript:return confirm('<?php echo __("Delete this company?");?>');">
                    <img src="images/actions/delete.gif" width="16" height="16" class="absmiddle" alt="<?php echo __("delete");?>" border="0" />&nbsp;<?php echo __("Delete");?>
                </a>
                &nbsp;&nbsp;&nbsp;&nbsp;
            <?php endif; ?>
            <?php if ($thisTpl->privledgedUser): ?>
                <a id="history_link" href="<?php echo(CATSUtility::getIndexName()); ?>?m=settings&amp;a=viewItemHistory&amp;dataItemType=200&amp;dataItemID=<?php echo($thisTpl->companyID); ?>">
                    <img src="images/icon_clock.gif" width="16" height="16" class="absmiddle"  border="0" />&nbsp;<?php echo __("View History");?>
                </a>
                &nbsp;&nbsp;&nbsp;&nbsp;
            <?php endif; ?>
            <?php 
            if ($top) {
            	tplAddAttachment($thisTpl);
            	tplAddJobOrder($thisTpl);
            	tplAddContact($thisTpl);
            	}
            ?>
            <?php if ($thisTpl->getUserAccessLevel('companies.edit') >= ACCESS_LEVEL_EDIT): ?>
            	<a href="javascript:void(0);" onclick="showQuickActionAddToList(200, 162);">
            		<img src="assets/svg/icon.svg" width="16" height="16" class="absmiddle" alt="Dodaj do listy" border="0" />&nbsp;Dodaj do listy
            	</a>
            <?php endif; ?>
<?php
}

?>
    <div id="main">
        <?php TemplateUtility::printQuickSearch(); ?>

        <div id="contents">
            <table>
                <tr>
                    <td width="3%">
                        <img src="images/companies.gif" width="24" height="24" border="0" alt="Companies" style="margin-top: 3px;" />&nbsp;
                    </td>
                    <td><h2><?php echo __("Companies");?>: <?php echo __("Company Details");?></h2></td>
               </tr>
            </table>
			
			<?php tplActions($this,true);?>
	
            <p class="note"><?php echo __("Company Details");?></p>

            <table class="detailsOutside">
                <tr style="vertical-align:top;">
                    <td width="50%" height="100%">
                        <table class="detailsInside" height="100%">
                            <!--tr>
                                <td class="vertical"><?php echo __("Name");?>:</td>
                                <td class="data">
                                    <span class="<?php echo($this->data['titleClass']); ?>"><?php $this->_($this->data['name']); ?></span>
                                    <?php TemplateUtility::printSingleQuickActionMenu(new QuickActionMenu(DATA_ITEM_COMPANY, $this->companyID, $_SESSION['CATS']->getAccessLevel('companies.edit'))); ?>
                                </td>
                            </tr-->

                            <!-- CONTACT INFO -->

                            <!--tr>
                                <td class="vertical"><?php echo __("Primary Phone");?>:</td>
                                <td class="data"><?php $this->_($this->data['phone1']); ?></td>
                            </tr>

                            <tr>
                                <td class="vertical"><?php echo __("Secondary Phone");?>:</td>
                                <td class="data"><?php $this->_($this->data['phone2']); ?></td>
                            </tr-->

                            <!--tr>
                                <td class="vertical"><?php echo __("Fax Number");?>:</td>
                                <td class="data"><?php $this->_($this->data['faxNumber']); ?></td>
                            </tr>

                            <tr>
                                <td class="vertical"><?php echo __("Address");?>:</td>
                                <td class="data"><?php echo(nl2br(htmlspecialchars($this->fl['fullAddress']))); ?>&nbsp;
                                <?php echo($this->data['googleMaps']); ?></td>
                            </tr>

                            <tr>
                                <td class="vertical">&nbsp;</td>
                                <td class="data">
                                    <?php $this->_($this->data['cityAndState']); ?>
                                    <?php $this->_($this->data['zip']); ?>
                                </td>
                            </tr-->
                            
                            <tr><td colspan="2">
                         <?php 
                    		E::showCustomFields(array(
                    			'dataItem'=>'company',
                    			'section'=>'custom1',
                    			'template'=>'read',
                    			'fl'=>$this->fl,
                    			)); 
                    	 ?>                                 
                                </td></tr>

                            <?php for ($i = 0; $i < intval(count($this->extraFieldRS)/2); $i++): ?>
                               <tr>
                                    <td class="vertical"><?php $this->_($this->extraFieldRS[$i]['fieldName']); ?>:</td>
                                    <td class="data"><?php echo($this->extraFieldRS[$i]['display']); ?></td>
                               </tr>
                            <?php endfor; ?>

                            <!-- /CONTACT INFO -->
                       </table>
                    </td>

                    <td width="50%" height="100%">
                        <table class="detailsInside" height="100%">
                        <!-- CONTACT INFO -->
                            <tr>
                                <td class="vertical"><?php echo __("Web Site");?>:</td>
                                <td class="data">
                                    <a href="<?php $this->_($this->data['url']); ?>" target="_blank">
                                        <?php $this->_($this->data['url']); ?>
                                    </a>
                                </td>
                            </tr>

                            
                            <tr><td colspan="2">
                         <?php 
                    		E::showCustomFields(array(
                    			'dataItem'=>'company',
                    			'section'=>'custom2',
                    			'template'=>'read',
                    			'fl'=>$this->fl,
                    			)); 
                    	 ?>                                 
                                </td></tr>                            

                        <!-- /CONTACT INFO -->

                            <tr>
                                <td class="vertical"><?php echo __("Key Technologies");?>:</td>
                                <td class="data"><?php $this->_($this->data['keyTechnologies']); ?></td>
                            </tr>
                            
                            <tr>
                                <td class="vertical"><?php echo __("Billing Contact");?>:</td>
                                <td class="data">
                                    <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=contacts&amp;a=show&amp;contactID=<?php echo($this->data['billingContact']); ?>">
                                        <?php $this->_($this->data['billingContactFullName']); ?>
                                    </a>
                                </td>
                            </tr>                            

                            <tr>
                                <td class="vertical"><?php echo __("Created");?>:</td>
                                <td class="data"><?php $this->_(evConvertDateDbToDateTime($this->data['dateCreatedDb'])); ?> (<?php $this->_($this->data['enteredByFullName']); ?>)</td>
                            </tr>

                            <tr>
                                <td class="vertical"><?php echo __("Owner");?>:</td>
                                <td class="data"><?php $this->_($this->data['ownerFullName']); ?></td>
                            </tr>

                            <tr>
                                <td class="vertical">&nbsp;</td>
                                <td class="data">&nbsp;</td>
                            </tr>
                            
                            

                        <!-- CONTACT INFO -->

                            <?php for ($i = (intval(count($this->extraFieldRS))/2); $i < (count($this->extraFieldRS)); $i++): ?>
                                <tr>
                                    <td class="vertical"><?php $this->_($this->extraFieldRS[$i]['fieldName']); ?>:</td>
                                    <td class="data"><?php echo($this->extraFieldRS[$i]['display']); ?></td>                                </tr>
                            <?php endfor; ?>

                        <!-- /CONTACT INFO -->
                        </table>
                    </td>
                </tr>
            </table>

            <!-- CONTACT INFO -->
            <?php if (count($this->departmentsRS) > 0): ?>
                <table class="detailsOutside">
                    <tr>
                        <td>
                            <table class="detailsInside">
                                <tr>
                                    <td valign="top" class="vertical"><?php echo __("Departments");?>:</td>
                                    <td valign="top" class="data">
                                        <?php foreach ($this->departmentsRS as $departmentRecord): ?>
                                            <?php $this->_($departmentRecord['name']); ?>
                                            <br />
                                        <?php endforeach; ?>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            <?php endif; ?>
            <!-- /CONTACT INFO -->

            <!-- CONTACT INFO -->
            <table class="detailsOutside">
                <tr>
                    <td>
                        <table class="detailsInside">
                            <tr>
                                <td valign="top" class="vertical"><?php echo __("Attachments");?>:</td>
                                <td valign="top" class="data">
                                    <table class="attachmentsTable">
                                        <?php foreach ($this->attachmentsRS as $rowNumber => $attachmentsData): ?>
                                            <tr>
                                                <td>
                                                    <?php echo $attachmentsData['retrievalLink']; ?>
                                                        <img src="<?php $this->_($attachmentsData['attachmentIcon']) ?>" alt="" width="16" height="16" border="0" />
                                                        &nbsp;
                                                        <?php $this->_($attachmentsData['originalFilename']) ?>
                                                    </a>
                                                </td>
                                                <td><?php $this->_(evConvertDateDbToDateTime($attachmentsData['dateCreatedDb'])) ?></td>
                                                <td>
                                                    <?php if ($this->getUserAccessLevel('companies.deleteAttachment') >= ACCESS_LEVEL_DELETE): ?>
                                                        <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=companies&amp;a=deleteAttachment&amp;companyID=<?php echo($this->companyID); ?>&amp;attachmentID=<?php $this->_($attachmentsData['attachmentID']) ?>"  title="Delete" onclick="javascript:return confirm('<?php echo __("Delete this attachment?");?>');">
                                                            <img src="images/actions/delete.gif" alt="" width="16" height="16" border="0" />
                                                        </a>
                                                    <?php endif; ?>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    </table>
									<?php tplAddAttachment($this);?>		
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="vertical"><?php echo __("Misc. Notes");?>:</td>
                                <?php if ($this->isShortNotes): ?>
                                    <td id="shortNotes" style="display:block;" class="data">
                                        <?php echo($this->data['shortNotes']); ?><span class="moreText">...</span>&nbsp;
                                        <p><a href="#" class="moreText" onclick="toggleNotes(); return false;"><?php echo __("[More]");?></a></p>
                                    </td>
                                    <td id="fullNotes" style="display:none;" class="data">
                                        <?php echo($this->data['notes']); ?>&nbsp;
                                        <p><a href="#" class="moreText" onclick="toggleNotes(); return false;"><?php echo __("[Less]");?></a></p>
                                    </td>
                                <?php else: ?>
                                    <td id="shortNotes" style="display:block;" class="data">
                                        <?php echo($this->data['notes']); ?>
                                    </td>
                                <?php endif; ?>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <!-- /CONTACT INFO -->
			<?php tplActions($this);?>

            <br clear="all" />
            <br />

            <p class="note"><?php echo __("Job Orders");?></p>
            <table class="sortable">
                <tr>
                    <th align="left" width="30" nowrap="nowrap"><?php echo __("ID");?></th>
                    <th align="left" width="200"><?php echo __("Title");?></th>
                    <th align="left" width="15"><?php echo __("Type");?></th>
                    <th align="left" width="15"><?php echo __("Status");?></th>
                    <th align="left" width="60"><?php echo __("Created");?></th>
                    <th align="left" width="60"><?php echo __("Modified");?></th>
                    <th align="left" width="60"><?php echo __("Start");?></th>
                    <th align="left" width="15"><?php echo __("Age");?></th>
                    <th align="left" width="10"><?php echo __("S");?></th>
                    <th align="left" width="10"><?php echo __("P");?></th>
                    <th align="left" width="65"><?php echo __("Recruiter");?></th>
                    <th align="left" width="68"><?php echo __("Owner");?></th>
                    <th align="left" width="25"><?php echo __("Action");?></th>
                </tr>

                <?php foreach ($this->jobOrdersRS as $rowNumber => $jobOrdersData): ?>
                    <tr class="<?php TemplateUtility::printAlternatingRowClass($rowNumber); ?>">
                        <td valign="top" align="left"><?php $this->_($jobOrdersData['jobOrderID']) ?></td>
                        <td valign="top">
                            <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=joborders&amp;a=show&amp;jobOrderID=<?php $this->_($jobOrdersData['jobOrderID']) ?>">
                                <?php $this->_($jobOrdersData['title']) ?>
                            </a>
                        </td>
                        <td valign="top" align="left"><?php $this->_($jobOrdersData['type']) ?></td>
                        <td valign="top" align="left"><?php $this->_(EnumTypeEnum::jobOrderStatus()->enumByAttr('dbValue',$jobOrdersData['status'])->desc) ?></td>
                        <td valign="top" align="left"><?php $this->_($jobOrdersData['dateCreated']) ?></td>
                        <td valign="top" align="left"><?php $this->_($jobOrdersData['dateModified']) ?></td>
                        <td valign="top" align="left"><?php $this->_($jobOrdersData['startDate']) ?></td>
                        <td valign="top" align="left"><?php $this->_($jobOrdersData['daysOld']) ?></td>
                        <td valign="top" align="left"><?php $this->_($jobOrdersData['submitted']); ?></td>
                        <td valign="top" align="left"><?php $this->_($jobOrdersData['pipeline']); ?></td>
                        <td valign="top" align="left"><?php $this->_($jobOrdersData['recruiterAbbrName']); ?></td>
                        <td valign="top" align="left"><?php $this->_($jobOrdersData['ownerAbbrName']); ?></td>
                        <td valign="top" align="center">
                            <?php if ($this->getUserAccessLevel('joborders.edit') >= ACCESS_LEVEL_EDIT): ?>
                                <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=joborders&amp;a=edit&amp;jobOrderID=<?php $this->_($jobOrdersData['jobOrderID']) ?>">
                                    <img src="images/actions/edit.gif" width="16" height="16" class="absmiddle" alt="edit" border="0" />
                                </a>
                            <?php endif; ?>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </table>
			<?php tplAddJobOrder($this);?>

            <br clear="all" />
            <br />

            <!-- CONTACT INFO -->
            <p class="note">Contacts</p>
            <table class="sortable">
                <tr>
                    <th align="left" nowrap="nowrap"><?php echo __("First Name");?></th>
                    <th align="left" nowrap="nowrap"><?php echo __("Last Name");?></th>
                    <th align="left"><?php echo __("Title");?></th>
                    <th align="left"><?php echo __("Department");?></th>
                    <th align="left" nowrap="nowrap"><?php echo __("Work Phone");?></th>
                    <th align="left" nowrap="nowrap"><?php echo __("Cell Phone");?></th>
                    <th align="left"><?php echo __("Created");?></th>
                    <th align="left"><?php echo __("Owner");?></th>
                    <th align="center"><?php echo __("Action");?></th>
                </tr>

                <?php if (count($this->contactsRSWC) != 0): ?>
                 <?php foreach ($this->contactsRSWC as $rowNumber => $contactsData): ?>
                    <tr id="ContactsDefault<?php echo($rowNumber) ?>" class="<?php TemplateUtility::printAlternatingRowClass($rowNumber); ?>">
                        <td valign="top" align="left">
                            <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=contacts&amp;a=show&amp;contactID=<?php $this->_($contactsData['contactID']) ?>" class="<?php $this->_($contactsData['linkClass']); ?>">
                                <?php $this->_($contactsData['firstName']) ?>
                            </a>
                        </td>
                        <td valign="top" align="left">
                            <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=contacts&amp;a=show&amp;contactID=<?php $this->_($contactsData['contactID']) ?>" class="<?php $this->_($contactsData['linkClass']); ?>">
                                <?php $this->_($contactsData['lastName']) ?>
                            </a>
                        </td>
                        <td valign="top" align="left"><?php $this->_($contactsData['title']) ?></td>
                        <td valign="top" align="left"><?php $this->_($contactsData['department']) ?></td>
                        <td valign="top" align="left"><?php $this->_($contactsData['phoneWork']) ?></td>
                        <td valign="top" align="left"><?php $this->_($contactsData['phoneCell']) ?></td>
                        <td valign="top" align="left"><?php $this->_($contactsData['dateCreated']) ?></td>
                        <td valign="top" align="left"><?php $this->_($contactsData['ownerAbbrName']); ?></td>
                        <td valign="top" align="center">
                            <?php if (!empty($contactsData['email1'])): ?>
                                <a href="mailto:<?php $this->_($contactsData['email1']); ?>" title="Send E-Mail (<?php $this->_($contactsData['email1']); ?>)">
                                    <img src="images/actions/email.gif" width="16" height="16" alt="" class="absmiddle" border="0" />
                                </a>
                            <?php else: ?>
                                <img src="images/actions/email_no.gif" title="No E-Mail Address" width="16" height="16" alt="" class="absmiddle" border="0" />
                            <?php endif; ?>
                            <?php if ($this->getUserAccessLevel('contacts.edit') >= ACCESS_LEVEL_EDIT): ?>
                                <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=contacts&amp;a=edit&amp;contactID=<?php $this->_($contactsData['contactID']) ?>">
                                    <img src="images/actions/edit.gif" width="16" height="16" class="absmiddle" alt="<?php echo __("edit");?>" border="0" />
                                </a>
                            <?php endif; ?>
                        </td>
                    </tr>
                <?php endforeach; ?>
               <?php endif; ?>

                <?php /* The following are hidden by default */ ?>
                <?php if (count($this->contactsRSWC) != count($this->contactsRS) && count($this->contactsRS) != 0) : ?>
                 <?php foreach ($this->contactsRS as $rowNumber => $contactsData): ?>
                    <tr id="ContactsFull<?php echo($rowNumber) ?>" class="<?php TemplateUtility::printAlternatingRowClass($rowNumber); ?>" style="display:none;">
                        <td valign="top" align="left">
                            <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=contacts&amp;a=show&amp;contactID=<?php $this->_($contactsData['contactID']) ?>" class="<?php $this->_($contactsData['linkClass']); ?>">
                                <?php $this->_($contactsData['firstName']) ?>
                            </a>
                        </td>
                        <td valign="top" align="left">
                            <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=contacts&amp;a=show&amp;contactID=<?php $this->_($contactsData['contactID']) ?>" class="<?php $this->_($contactsData['linkClass']); ?>">
                                <?php $this->_($contactsData['lastName']) ?>
                            </a>
                        </td>
                        <td valign="top" align="left"><?php $this->_($contactsData['title']) ?></td>
                        <td valign="top" align="left"><?php $this->_($contactsData['department']) ?></td>
                        <td valign="top" align="left"><?php $this->_($contactsData['phoneWork']) ?></td>
                        <td valign="top" align="left"><?php $this->_($contactsData['phoneCell']) ?></td>
                        <td valign="top" align="left"><?php $this->_($contactsData['dateCreated']) ?></td>
                        <td valign="top" align="left"><?php $this->_($contactsData['ownerAbbrName']); ?></td>
                        <td valign="top" align="center">
                            <?php if (!empty($contactsData['email1'])): ?>
                                <a href="mailto:<?php $this->_($contactsData['email1']); ?>">
                                    <img src="images/actions/email.gif" width="16" height="16" alt="" class="absmiddle" border="0" title="<?php echo __("Send E-Mail");?> (<?php $this->_($contactsData['email1']); ?>)"/>
                                </a>
                            <?php else: ?>
                                <img src="images/actions/email_no.gif" title="<?php echo __("No E-Mail Address");?>" width="16" height="16" alt="" class="absmiddle" border="0" />
                            <?php endif; ?>
                            <?php if ($this->getUserAccessLevel('contacts.edit') >= ACCESS_LEVEL_EDIT): ?>
                                <a href="<?php echo(CATSUtility::getIndexName()); ?>?m=contacts&amp;a=edit&amp;contactID=<?php $this->_($contactsData['contactID']) ?>">
                                    <img src="images/actions/edit.gif" width="16" height="16" class="absmiddle" alt="<?php echo __("edit");?>" border="0" />
                                </a>
                            <?php endif; ?>
                        </td>
                    </tr>
                 <?php endforeach; ?>
                <?php endif; ?>

            </table>

			<?php tplAddContact($this);?>
            <!-- /CONTACT INFO -->
        </div>
    </div>

<?php TemplateUtility::printFooter(); ?>
